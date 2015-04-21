class HomeController < ApplicationController

  def index
    @subscription = Subscription.new
    @series = Series.order(:name)
  end
end
