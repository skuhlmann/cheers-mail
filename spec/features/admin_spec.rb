require 'rails_helper'

describe 'the admin user flow', type: :feature do

  let(:user)  {User.create(email_address: "sam@email.com", admin: true, password: "password")}
  let(:subscription)  {Subscription.create(email_address: "coll@email.com", name: "Colleen")}

  before(:each) do
    series = Series.create(name: "cheers", seasons: 1)
    episode = Episode.create(summary: "lorem ipsum", season: 1)
    series.episodes << episode
    subscription.series << series
    user.save
    subscription.save
    visit login_path
    page.fill_in('email_address', with: 'sam@email.com')
    page.fill_in('password', with: 'password')
    page.click_button('Login')
  end

  it "can see a list of the latest subscriptions" do
    visit admin_index_path
    expect(page).to have_text("Colleen")
    expect(page).to have_text("coll@email.com")
  end

  it "can see a list of the latest subscriptions" do
    visit admin_index_path
    page.click_link("View full subscription list")

    expect(current_path).to eq("/admin/subscriptions")
    expect(page).to have_text("coll@email.com")
  end

  it "can subscribe someone to the list" do
    visit admin_index_path
    page.click_link("View full subscription list")
    page.fill_in('subscription_email_address', with: 'leonardo@email.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.check('series_ids[]')
    page.click_button('Create Subscription')

    expect(page).to have_content("Leo")
  end

  it "can add a new series" do
    visit admin_index_path
    page.click_link('Add a new series')

    expect(current_path).to eq(new_admin_series_path)
    VCR.use_cassette("admin_series_friends") do
      page.fill_in('series_name', with: "Friends")
      page.fill_in('series_seasons', with: "2")
      page.click_button("Create Series")

      series = Series.last

      expect(current_path).to eq(admin_series_path(series))
      expect(page).to have_content("Friends")
      expect(page).to have_content("Joey needs to practice kissing guys")
    end
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
end
