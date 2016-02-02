namespace :posses do
  desc "Generate user records for all members listed in Slack Usergroups"
  task :import => :environment do
    PosseImporter.run!
  end
end
