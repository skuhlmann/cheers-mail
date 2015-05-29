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

  it "can add a new single page series" do
    visit admin_index_path
    page.click_link('Add a new series')

    VCR.use_cassette("admin_series_curb") do
      page.fill_in('series_name', with: "curb your enthusiasm")
      page.fill_in('series_seasons', with: "8")
      page.check("single_page")
      page.click_button("Create Series")

      series = Series.last

      expect(current_path).to eq(admin_series_path(series))
      expect(page).to have_content("Curb Your Enthusiasm")
      expect(page).to have_content("Larry must befriend his next-door neighbors, the Weinstocks")
    end
  end
end