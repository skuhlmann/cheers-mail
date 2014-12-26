require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :email_address => "Email Address",
      :admin => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email Address/)
    expect(rendered).to match(/false/)
  end
end
