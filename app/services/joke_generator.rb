class JokeGenerator < ApplicationService
	attr_accessor :humour, :context

  def initialize(humour, context)
		@humour = humour
		@context = context
	end

  def perform
		uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{Rails.application.credentials[:gemini_api_key]}")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = (uri.scheme == "https")
		request = Net::HTTP::Post.new(uri.request_uri)
		request["Content-Type"] = "application/json"

		request.body = request_body
		response = http.request(request)
		JSON.parse(response.body)['candidates'].first['content']['parts'].first['text']
	end

	def request_body
		data = {
			contents: [{
    		parts: [{ text: "You are an API that generates jokes, no jokes about crossing. Make a greate joke please. I might die if you say a bad joke. Use this JSON to generate the joke with a character limit of 255 and no formatting: { humour: \"#{humour}\", context: \"#{context}\" }" }]
  		}]
		}

		data.to_json
	end
end
