require 'clockwork'
require File.expand_path('../../../config/boot',        __FILE__)
require File.expand_path('../../../config/environment', __FILE__)

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.week, 'weekly.job', :at => 'Sunday 12:20') { Subscription.weekly_blast }
end
