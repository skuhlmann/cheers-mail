require 'rails_helper'

describe "the subscriber user flow", type: :feature do

  let(:subscription)  {Subscription.create(email_address: "coll@email.com", name: "Colleen")}

  it "can visit the homepage and subscribe" do
    visit root_path
    page.fill_in('subscription_email_address', with: 'leonardo@email.com')
    page.fill_in('subscription_name', with: 'Leo')
    page.click_button('Create Subscription')
    expect(page).to have_content("You've been subscribed.")
  end

  it "can unsubscribe from the list" do
    subscription.save
    visit root_path
    page.click_link('Unsubscribe')
    expect(current_path).to eq('/unsubscribe')
    page.fill_in('subscription_email_address', with: 'coll@email.com')
    page.click_button('Unsubscribe me')
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You've been unsubscribed.")
  end

  it "cannnot unsubscribe from the list if the email doesn't exist" do
    visit root_path
    page.click_link('Unsubscribe')
    expect(current_path).to eq('/unsubscribe')
    page.fill_in('subscription_email_address', with: 'joebob@email.com')
    page.click_button('Unsubscribe me')
    expect(current_path).to eq(unsubscribe_path)
    expect(page).to have_content("The email address provided is not currently subscribed.")
  end


end
