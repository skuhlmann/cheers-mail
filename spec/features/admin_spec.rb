require 'rails_helper'

describe 'the admin user flow', type: :feature do

  let(:user)  {User.create(email_address: "sam@email.com", admin: true, password: "password")}
  let(:subscription)  {Subscription.create(email_address: "coll@email.com", name: "Colleen")}

  before(:each) do
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
    page.click_button('Create Subscription')
    expect(page).to have_content("Leo")
  end

  it "can add a new series" do
    visit admin_index_path
    page.click_button('Add a show')
    expect(current_path).to eq(new_admin_episode_path)
    page.fill_in('show_title', with: "Cheers")
    page.fill_in('episode_amount', with: "11")
    page.click_button("Add Show")
    expect(current_path).to eq("/admin/espisodes/1")
    expect(page).to have_content("Cheers")
    expect(page).to have_content("Gary's Old Towne Tap")
  end


end
