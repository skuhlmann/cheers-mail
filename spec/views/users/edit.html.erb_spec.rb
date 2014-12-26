require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :email_address => "MyString",
      :admin => false
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_email_address[name=?]", "user[email_address]"

      assert_select "input#user_admin[name=?]", "user[admin]"
    end
  end
end
