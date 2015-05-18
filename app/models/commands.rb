#render Commands.parse(params[:text], params.slice(:token, :uid)).response
module Commands
  def self.parse(message_text, options={})
    case message_text
    when /#pc \d+/
      Commands::AwardPoints.new(message_text, options).response
    when /#pc standings/
      Commands::Standings.new(message_text, options).response
    else
      Commands::Invalid.new(message_text, options).response
    end
  end
end
