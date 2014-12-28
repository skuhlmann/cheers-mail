require 'rails_helper'

describe "the subscriber user flow", type: :feature do

  it "can visit the homepage and subscribe" do
    visit root_path
    page.fill_in('subscription_email_address', with: 'leonardo@email.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.click_button('Create Subscription')
    expect(page).to have_content("You've been subscribed.")
  end

end
