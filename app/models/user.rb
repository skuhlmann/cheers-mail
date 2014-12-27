class User < ActiveRecord::Base
  has_secure_password :validations => false
  validates :email_address, presence: true
end
