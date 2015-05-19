class Commands::Standings < Commands::Base
  def response
    {"json" => {"text" => message}, "status" => 200}
  end

  def message
    Posse.where.not(name: "Staff").
      group_by(&:current_score).
      sort_by(&:first).
      reverse.
      map.with_index do |group, index|
        points, posses = group
        position = (index + 1).ordinalize
        if posses.length > 1
          "#{position} (tie): #{posses.map(&:name).join(", ")} (#{points} points)"
        else
          "#{position}: #{posses.first.name} (#{points} points)"
        end
      end.join("\n")
  end
end
