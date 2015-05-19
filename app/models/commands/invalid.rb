class Commands::Invalid < Commands::Base
  def response
    {json: {text: "Sorry, I couldn't understand the command #{text}" }, status: 200}
  end
end
