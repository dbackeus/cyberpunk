# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

YAML.load_file("db/skills.yml").each do |attributes|
  Skill.create!(attributes)
end

YAML.load_file("db/roles.yml").each do |attributes|
  career_skill_names = attributes.delete('career_skills') || []
  career_skill_ids = Skill.where(:name.in => career_skill_names).collect(&:id)
  Role.create!(attributes.merge(career_skill_ids: career_skill_ids))
  # Role.find_by(name: attributes['name']).update_attributes(career_skill_ids: career_skill_ids)
end

require 'csv'

csv_data = CSV.read 'db/weapons.csv'
headers = csv_data.shift.collect(&:to_s)
string_data = csv_data.collect { |row| row.collect(&:to_s) }
weapons = string_data.map { |row| Hash[*headers.zip(row).flatten] }

weapons.each do |attributes|
  WeaponBlueprint.create!(attributes)
end
