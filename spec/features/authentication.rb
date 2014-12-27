require 'rails_helper'

describe 'the authentication process', type: :feature do

  let(:user)  {User.create(email_address: "colleen@email.com")}
  let(:admin_user)  {User.create(email_address: "sam@email.com", admin: true, password: "password")}

  it "can login and view the users page if admin" do
    user.save
    admin_user.save
    visit login_path
    page.fill_in('email_address', with: 'sam@email.com')
    page.fill_in('password', with: 'password')
    page.click_button('Login')

    expect(current_path).to eq(users_path)
    expect(page).to have_content('colleen@email.com')
  end

  it "can not access user sections if not logged in" do
    visit users_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Unauthorized")
  end

end
