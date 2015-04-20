class Loader

  def self.service
    @service ||= WikiService.new
  end

  def self.find_all_episodes(titles)
    service.collect_data(titles)
  end

end
