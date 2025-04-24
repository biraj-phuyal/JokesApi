# frozen_string_literal: true

# this is jokegenarator
class JokeGenerator < ApplicationService
  attr_accessor :humour, :context

  GEMINI_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{Rails.application.credentials[:gemini_api_key]}"

  def initialize(humour, context)
    super
    @humour = humour
    @context = context
  end

  def perform
    return if humour.blank? || context.blank?

    response = http.request(request)
    JSON.parse(response.body)['candidates'].first['content']['parts'].first['text']
  end

  def request
    uri = URI.parse(GEMINI_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    request_obj = Net::HTTP::Post.new(uri.request_uri)
    request_obj['Content-Type'] = 'application/json'
    request_obj.body = request_body
    request_obj
  end

  def request_body
    {
      contents: [{
        parts: [{ text: "\
        You are an API that generates jokes, no jokes about crossing. Make a greate joke please. \
        I might die if you say a bad joke. Use this JSON to generate the joke with a character \
        limit of 255 and no formatting: { humour: \"#{humour}\", context: \"#{context}\" }\
        " }]
      }]
    }.to_json
  end
end
