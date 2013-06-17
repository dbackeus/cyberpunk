class Role
  include Mongoid::Document

  field :name, type: String
  field :preferred_stats, type: Array, default: []
  field :career_skill_ids, type: Array, default: []

  validates :name, presence: true, uniqueness: true

  def career_skills
    @career_skills ||= Skill.find(career_skill_ids)
  end
end
