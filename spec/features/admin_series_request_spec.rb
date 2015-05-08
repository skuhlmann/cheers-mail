require 'rails_helper'

describe 'the admin series request flow', type: :feature do

  let(:user)  {User.create(email_address: "sam@example.com", admin: true, password: "password")}
  let(:subscription)  {Subscription.create(email_address: "coll@example.com", name: "Colleen")}

  before(:each) do
    request = SeriesRequest.create(name: "Three's Company")
    request.subscription = subscription
    user.save
    subscription.save
    visit login_path
    page.fill_in('email_address', with: 'sam@example.com')
    page.fill_in('password', with: 'password')
    page.click_button('Login')
  end

  it "can see a list of series requests" do
    expect(page).to have_text("Latest Series Requests")
    expect(page).to have_text("Three's Company (request)")
    expect(page).to have_text(subscription.name)
    expect(page).to have_text(subscription.email_address)
  end

  it "can mark a series request as fulfilled" do
    page.click_link("Three's Company request fulfilled")

    expect(page).not_to have_text("Three's Company (request)")
  end
end

