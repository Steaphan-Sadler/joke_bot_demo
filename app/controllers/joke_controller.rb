class JokeController < ApplicationController
  require "httparty"

  def fetch
    #get contact_id from webhook
    Rails.logger.debug params.inspect
    @message_id = params[:conversationId]
    

      #get the joke
      fetched_joke = HTTParty.get("https://icanhazdadjoke.com/", {
        headers: { "Accept" => "application/json" }
      })

    send_joke_headers = {"Authorization" => "Bearer #{ENV['JOKE_BOT_TOKEN']}", "content-type" => "application/json"}
    send_joke_body = {"type" => "chat", "body" => fetched_joke['joke']}

      #send the joke to the conversation
    send_joke_response = HTTParty.post("https://driftapi.com/conversations/#{@message_id}/messages", headers: send_joke_headers, body: send_joke_body.to_json)
    Rails.logger.debug "This was the response: #{send_joke_response}"
  end
end