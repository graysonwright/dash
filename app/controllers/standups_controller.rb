require "basecamp_standup_parser"
require "bart"

class StandupsController < ApplicationController
  before_filter :find_bad_ass_gif

  def index
    client = BasecampClient.new
    messages = client.standup_messages
    parser = BasecampStandupParser.new(messages.to_json)
    @summaries = parser.standups
    @bart_departures = Bart.new.next_departing_trains(5)
  end

  def find_bad_ass_gif
    response = HTTParty.get("http://api.giphy.com/v1/gifs/trending?api_key=#{ENV["GIPHY_PUBLIC_KEY"]}")
    random_selection = rand(response["data"].count)
    @embed_url = response["data"][random_selection]["embed_url"]
  end
end
