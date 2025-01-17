class JokeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def fetch
    #get the joke we'll send somewhere
    fetched_joke = HTTParty.get("https://icanhazdadjoke.com/", {
      headers: { "Accept" => "application/json" },
    })

    #prep headers for Drift API
    send_joke_headers = { "Authorization" => "Bearer #{ENV.fetch("JOKE_BOT_TOKEN")}", "content-type" => "application/json" }

    #if user answers yes, we'll send a joke
    if params[:data][:body] == "Yes"
      # message_id = params[:data][:conversationId]
      # send_joke_body = { "type" => "chat", "body" => fetched_joke["joke"] }
      # #send the joke to the conversation
      # HTTParty.post("https://driftapi.com/conversations/#{message_id}/messages", headers: send_joke_headers, body: send_joke_body.to_json)

      send_joke_body = { "attributes" => { "jokebot_joke" => fetched_joke["joke"] } }
      #for updating contact modle with joke
      HTTParty.patch("https://driftapi.com/contacts/#{params[:data][:author][:id]}", headers: send_joke_headers, body: send_joke_body.to_json)
    end
  end
end
