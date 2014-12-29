class Subscription < ActiveRecord::Base
  validates :email_address, :name, presence: true
  validates :email_address, uniqueness: true
  validates :email_address, format: { with: /.+@.+\..+/, message: "invalid email format" }

  def self.recent
    self.last(3)
  end
end
