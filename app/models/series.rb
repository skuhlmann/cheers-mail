class Series < ActiveRecord::Base
  has_many :episodes
  has_and_belongs_to_many :subscriptions

  before_save :parse_title

  validates :name, :seasons, presence: true
  validates :name, uniqueness: true

  def parse_title
    self.name = name.titleize
  end

  def gather_episodes
    Episode.build_episodes(name, seasons, id)
  end
end
