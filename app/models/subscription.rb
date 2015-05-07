class Subscription < ActiveRecord::Base
  has_and_belongs_to_many :series
  has_one :series_request

  validates :email_address, :name, presence: true
  validates :email_address, uniqueness: true
  validates :email_address, format: { with: /.+@.+\..+/, message: "invalid email format" }
  validate :has_a_series

  def has_a_series
    unless self.series.present? || self.series_request.present?
      errors.add :base, "Please select a series, enter one that you don't see or both."
    end
  end

  def self.recent
    self.last(3)
  end

  def random_episode
    self.series.map { |series| series.random_episode }.sample
  end

  def self.weekly_blast
    all.each do |subscription|
      EpisodeMailer.weekly_episode_email(subscription).deliver
    end
  end
end
