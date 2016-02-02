require "slack"

Slack.configure do |config|
  config.token = ENV["SLACK_ADMIN_TOKEN"]
end

# Monkeypatch to match the generated code from this example:
# https://github.com/aki017/slack-ruby-gem/blob/dev/lib/slack/endpoint/usergroups.rb#L113-L121
# Takes a Usergroup ID and fetches list of users in that group
module Slack
  module Endpoint
    module Usergroups
      def usergroups_users_list(options={})
        throw ArgumentError.new("Required arguments :usergroup missing") if options[:usergroup].nil?
        post("usergroups.users.list", options)
      end
    end
  end
end

module PosseImporter
  def self.rosters
    {
      "Alan Kay"=>"@kay-roster",
      "Tim Berners-Lee"=>"@berners-lee-roster",
      "Fred Brooks"=>"@brooks-roster",
      "Donald Knuth"=>"@knuth-roster",
      "Ada Lovelace"=>"@lovelace-roster",
      "Grace Hopper"=>"@hopper-roster",
      "James Golick"=>"@golick-roster",
      "Weirich"=>"@weirich-roster",
      "Adele Goldberg"=>"@goldberg-roster",
      "Dennis Ritchie"=>"@ritchie-roster",
      "Ezra Zygmuntowicz"=>"@zygmuntowicz-roster",
      "Yukihiro Matsumoto"=>"@matsumoto-roster"
    }
  end

  def self.run!
    rosters.each do |posse_name,roster_group|
      "Puts Importing members for #{posse_name} from slack roster #{roster_group}"
      posse = Posse.find_or_create_by(name: posse_name)
      group = Slackk.user_group_by_handle(roster_group)
      Slackk.user_group_members(group["id"]).each do |slack_id|
        student = Student.find_or_create_by(slack_uid: slack_id)
        student_info = Slackk.member(slack_id)
        puts "Importing slack user #{slack_id} (#{student_info["real_name"]})"
        student.update_attributes(slack_name: student_info["name"],
                                  name: student_info["real_name"],
                                  posse_id: posse.id)
      end
    end
    puts "**********************"
    puts "Done importing. Now have #{Student.count} across #{Posse.count} posses."
  end
end
