class WikiService
  include HTTParty
  attr_reader :base_uri, :default_params

  def initialize
    @base_uri = "http://en.wikipedia.org/w/api.php"
    @default_params = { action: "query",
                        prop: "revisions",
                        format: "json",
                        rvprop: "content",
                      }
  end

  def collect_page_episodes(titles)
    default_params[:titles] = titles
    summaries(responses).map { |summary| summary.split("\n")
                                                .first.gsub(/[\]}=\/{|*+\\\[<>]/, "") }
                                                .drop(1)
  end

  def collect_list_episodes(titles)
    default_params[:titles] = titles
    response = HTTParty.get(base_uri, query: default_params)
    page_id = response["query"]["pages"].keys.first
    seasons = response["query"]["pages"][page_id]["revisions"].first["*"].split("===Season").drop(1)
    summaries = seasons.flat_map { |season| season.split("ShortSummary").drop(1) }
    summaries.map { |summary| summary.gsub(/[\]}=\/{|*+\\\[<>]/, "").split("\n").first }
  end

  private

  def responses
    HTTParty.get(base_uri, query: default_params)
  end

  def summaries(response)
    response["query"]["pages"][page_id(response)]["revisions"].first["*"]
                                                              .split("ShortSummary")
  end

  def page_id(response)
    response["query"]["pages"].keys.first
  end
end
