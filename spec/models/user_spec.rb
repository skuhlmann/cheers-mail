require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) {User.new(email_address: 'colleen@email.com', password: "password")}

  it "is invalid without an email address" do
    user.email_address = nil
    expect(user).not_to be_valid
  end
end
