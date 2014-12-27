class Subscription < ActiveRecord::Base
  validates :email_address, :name, presence: true
  validates :email_address, uniqueness: true
end
