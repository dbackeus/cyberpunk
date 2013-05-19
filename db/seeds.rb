# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(Solo Rocker Netrunner Media Nomad Fixer Cop Corp Techie Medtechie).each do |role|
  Role.create!(name: role)
end

YAML.load_file("db/skills.yml").each do |skill_atributes|
  Skill.create!(skill_atributes)
end
