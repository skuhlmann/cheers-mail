require 'rails_helper'

describe 'the admin user flow', type: :feature do

  let(:user)  {User.create(email_address: "sam@example.com", admin: true, password: "password")}
  let(:subscription)  {Subscription.create(email_address: "coll@example.com", name: "Colleen")}

  before(:each) do
    series = Series.create(name: "cheers", seasons: 1)
    episode = Episode.create(summary: "lorem ipsum", season: 1)
    series.episodes << episode
    subscription.series << series
    user.save
    subscription.save
    visit login_path
    page.fill_in('email_address', with: 'sam@example.com')
    page.fill_in('password', with: 'password')
    page.click_button('Login')
  end

  it "can see a list of the latest subscriptions" do
    visit admin_index_path
    expect(page).to have_text("Colleen")
    expect(page).to have_text("coll@example.com")
  end

  it "can see a list of the latest subscriptions" do
    visit admin_index_path
    page.click_link("View full subscription list")

    expect(current_path).to eq("/admin/subscriptions")
    expect(page).to have_text("coll@example.com")
  end

  it "can subscribe someone to the list" do
    visit admin_index_path
    page.click_link("View full subscription list")
    page.fill_in('subscription_email_address', with: 'leonardo@example.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.check('series_ids[]')
    page.click_button('Create Subscription')

    expect(page).to have_content("Leo")
  end

  it "can trigger a weekly email" do
    visit admin_index_path
    page.click_link("View full subscription list")
    page.fill_in('subscription_email_address', with: 'leonardo@example.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.check('series_ids[]')
    page.click_button('Create Subscription')
    page.click_button('Trigger weekly email to Leo')

    mail = ActionMailer::Base.deliveries.last

    expect(current_path).to eq(admin_subscriptions_path)
    expect(page).to have_content("Email sent")
    expect(mail.to.first).to eq("leonardo@example.com")
    expect(mail.subject).to eq("Do You Remember That One Episode of Cheers?")
  end

  it "can edit existing episode content" do
    visit admin_index_path
    page.click_link("View Cheers episodes")
    page.click_link("Edit episode summary")
    page.fill_in('episode_summary', with: 'New summary')
    page.click_button("Update Episode")

    series = Series.last

    expect(current_path).to eq(admin_series_path(series))
    expect(page).to have_content("New summary")
    expect(page).not_to have_content("lorem ipsum")
  end

  it "can delete a single episode" do
    visit admin_index_path
    page.click_link("View Cheers episodes")
    expect(page).to have_content("lorem ipsum")

    page.click_button("Delete episode", match: :first)

    series = Series.last

    expect(current_path).to eq(admin_series_path(series))
    expect(page).not_to have_content("lorem ipsum")
  end
end
