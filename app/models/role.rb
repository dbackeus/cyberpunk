class Role
  include Mongoid::Document
  
  field :name, type: String
  field :career_skill_ids, type: Array

  has_one :special_ability, class_name: "Skill"

  validates :name, presence: true, uniqueness: true
end
