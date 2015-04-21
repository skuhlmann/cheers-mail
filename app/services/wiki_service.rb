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

  def collect_data(titles)
    default_params[:titles] = titles
    summaries(responses).map { |summary| summary.split("\n")
                                                .first.gsub(/[\]}=\/{|*+\\\[<>]/, "") }
                                                .drop(1)
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
