class Commands::Standings < Commands::Base
  def response
    {"json" => {"text" => message}, "status" => 200}
  end

  def message
    ::Standings.new.list.join("\n")
  end
end
