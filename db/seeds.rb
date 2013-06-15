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
  career_skill_names = attributes.delete('career_skills')
  career_skill_ids = Skill.where(:name.in => career_skill_names).collect(&:id)
  Role.create!(attributes.merge(career_skill_ids: career_skill_ids, special_ability_id: special_ability.id))
  # Role.find_by(name: attributes['name']).update_attributes(career_skill_ids: career_skill_ids)
end
