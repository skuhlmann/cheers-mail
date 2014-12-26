class User < ActiveRecord::Base
  has_secure_password
  validates :email_address, presence: true
end
