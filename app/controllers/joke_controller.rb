class JokeController < ApplicationController
  require "httparty"

  def fetch

    if params[:data][:body] == "Yes"
    @convo_id = params[:orgId]

    #get the joke
    fetched_joke = httparty.get("https://icanhazdadjoke.com/", {
      headers: { "Accept" => "application/json" },
    })
    
    #send the joke to the conversation
    httparty.post("https://driftapi.com/conversations/#{@convo_id}/messages",{
      headers: {"Authorization" => "Bearer: #{ENV['JOKE_BOT_TOKEN']}"},
      body: {"type" =>"chat",
      "body": fetched_joke['joke']}
    })

  end
end