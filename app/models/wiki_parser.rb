class WikiParser < ActiveRecord::Base
  include HTTParty

  base_uri "http://en.wikipedia.org/w/api.php"
  default_params action: "query",
                 prop: "revisions",
                 format: "json",
                 rvprop: "content",
                 rvsection: "2"

  def self.collect_data(titles)
    default_params[:titles] = titles
    summaries(responses).map { |summary| summary.split("\n").first.gsub(/[]}=\/{|*+\\\[<>]/, "")}
  end

  def self.responses
     HTTParty.get(base_uri, query: default_params)
  end

  def self.summaries(response)
    response["query"]["pages"]["36249764"]["revisions"].first["*"].split("ShortSummary")
  end
end

