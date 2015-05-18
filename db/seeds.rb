# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Alan Kay",
 "Tim Berners-Lee",
 "Fred Brooks",
 "Donald Knuth",
 "Ada Lovelace",
 "Grace Hopper",
 "James Golick",
 "Weirich",
 "Adele Goldberg",
 "Dennis Ritchie",
 "Ezra Zygmuntowicz",
 "Yukihiro Matsumoto"].each do |pname|
  unless Posse.find_by(name: pname)
    Posse.create(name: pname)
  end
end
