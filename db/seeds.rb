# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = {
  "Solo" => %w[reflexes cool body_type],
  "Rocker" => %w[attractiveness cool empathy technical_ability],
  "Netrunner" => %w[intelligence technical_ability],
  "Media" => %w[attractiveness intelligence empathy cool],
  "Nomad" => %w[reflexes body_type technical_ability cool],
  "Fixer" => %w[cool empathy technical_ability reflexes],
  "Cop" => %w[reflexes cool empathy intelligence],
  "Corp" => %w[intelligence empathy attractiveness],
  "Techie" => %w[technical_ability intelligence],
  "Medtechie" => %w[technical_ability intelligence empathy],
}
roles.each do |name, stats|
  Role.create!(name: name, preferred_stats: stats)
end

YAML.load_file("db/skills.yml").each do |skill_atributes|
  Skill.create!(skill_atributes)
end
