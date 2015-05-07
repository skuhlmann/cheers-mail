require 'rails_helper'

describe "the subscriber user flow", type: :feature do

  let(:subscription)  {Subscription.create(email_address: "coll@example.com", name: "Colleen")}

  it "can visit the homepage and subscribe" do
    series = Series.create(name: "cheers", seasons: 1)
    episode = Episode.create(summary: "lorem ipsum", season: 1)
    series.episodes << episode

    visit root_path
    page.fill_in('subscription_email_address', with: 'leonardo@example.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.check('series_ids[]')
    page.click_button('Subscribe')

    expect(series.subscriptions.first.name).to eq('Leo')
    expect(page).to have_content("You've been subscribed.")
  end

  it "must select a series to subscribe to" do
    visit root_path
    page.fill_in('subscription_email_address', with: 'leonardo@example.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.click_button('Subscribe')

    expect(Subscription.count).to eq(0)
  end

  it "can unsubscribe from the list" do
    series = Series.create(name: "cheers", seasons: 1)
    subscription.series << series
    subscription.save

    visit root_path
    page.click_link('UNSUBSCRIBE')
    expect(current_path).to eq('/unsubscribe')
    page.fill_in('subscription_email_address', with: 'coll@example.com')
    page.click_button('Unsubscribe me')
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You've been unsubscribed.")
  end

  it "cannnot unsubscribe from the list if the email doesn't exist" do
    visit root_path
    page.click_link('UNSUBSCRIBE')
    expect(current_path).to eq('/unsubscribe')
    page.fill_in('subscription_email_address', with: 'joebob@example.com')
    page.click_button('Unsubscribe me')
    expect(current_path).to eq(unsubscribe_path)
    expect(page).to have_content("The email address provided is not currently subscribed.")
  end

  it "gets an email after subscribing from the homepage" do
    series = Series.create(name: "cheers", seasons: 1)
    episode = Episode.create(summary: "lorem ipsum", season: 1)
    series.episodes << episode

    visit root_path
    page.fill_in('subscription_email_address', with: 'leonardo@example.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.check('series_ids[]')
    page.click_button('Subscribe')

    mail = ActionMailer::Base.deliveries.last

    expect(page).to have_content("You've been subscribed.")
    expect(mail.to.first).to eq("leonardo@example.com")
  end

  it "can indicate a new series for subscription" do
    visit root_path
    page.fill_in('subscription_email_address', with: 'leonardo@example.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.fill_in('series_request', with: "Three's Company")
    page.click_button('Subscribe')

    expect(page).to have_content("You've been subscribed.")
    expect(page).to have_content("We are trying to find that series for you.")

    request = SeriesRequest.last

    expect(request.name).to eq("Three's Company")
    expect(request.subscription.name).to eq("Leo")
  end
end
