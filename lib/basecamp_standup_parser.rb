require "json"

class BasecampStandupParser
  def initialize(conversation_json)
    @conversation = JSON.parse(conversation_json, symbolize_names: true)
  end

  def status_for(name)
    first_comment_by(name)[:content]
  end

  def summary_for(name)
    status_for(name).scan(/\A[^\.]+/).first
  end

  private

  def first_comment_by(name)
    comments.find { |comment| comment[:creator][:name] == name}
  end

  def comments
    [original_post] + conversation[:comments]
  end

  def original_post
    {creator: conversation[:creator], content: conversation[:content]}
  end

  attr_reader :conversation
end
