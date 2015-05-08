class SeriesRequest < ActiveRecord::Base
  belongs_to :subscription

  def self.unfulfilled
    where(fulfilled: false)
  end
end
