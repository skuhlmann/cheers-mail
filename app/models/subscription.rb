class Subscription < ActiveRecord::Base
  has_and_belongs_to_many :series

  validates :email_address, :name, presence: true
  validates :email_address, uniqueness: true
  validates :email_address, format: { with: /.+@.+\..+/, message: "invalid email format" }
  validates :series, presence: { message: "you must select a series" }

  def self.recent
    self.last(3)
  end

  def random_episode
    self.series.map { |series| series.random_episode }.sample
  end
end
