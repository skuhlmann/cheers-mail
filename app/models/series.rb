class Series < ActiveRecord::Base
  has_many :episodes

  before_save :parse_title
  # before_save :create_episodes

  validates :name, :seasons, presence: true
  validates :name, uniqueness: true

  def parse_title
    self.name = name.titleize
  end

  def create_episodes

  end
end
