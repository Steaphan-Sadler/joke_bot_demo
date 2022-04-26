class JokeController < ApplicationController
  require "httparty"

  def fetch
    #get contact_id from webhook
    Rails.logger.debug params.inspect
    @data = params[:data]
    @contact_id = @data['endUserId']

      #get the joke
      fetched_joke = httparty.get("https://icanhazdadjoke.com/", {
        headers: { "Accept" => "application/json" },
      })

    send_joke_headers = {"Authorization" => "Bearer #{ENV['JOKE_BOT_TOKEN']}", "Accept" => "application/json"}
    send_joke_body = {"body" => {"attributes" => {"jokebot_joke" => "#{fetched_joke['joke']}"}}}

      #send the joke to the conversation
    send_joke_response = httparty.patch("https://driftapi.com/contacts/#{@contact_id}", headers: send_joke_headers, body: send_joke_body)
    Rails.logger.debug "This was the response: #{send_joke_response}"
  end
end