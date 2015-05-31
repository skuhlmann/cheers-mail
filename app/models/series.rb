class Series < ActiveRecord::Base
  has_many :episodes, dependent: :destroy
  has_and_belongs_to_many :subscriptions

  before_save :parse_title

  validates :name, :seasons, presence: true
  validates :name, uniqueness: true

  def parse_title
    self.name = name.titleize
  end

  def gather_episodes(single_page)
    Episode.build_episodes(name, seasons, id, single_page)
  end

  def random_episode
    self.episodes.order("RANDOM()").first
  end
end
