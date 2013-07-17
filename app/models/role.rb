class Role
  include Mongoid::Document

  field :name, type: String
  field :preferred_stats, type: Array, default: []
  field :career_skill_ids, type: Array, default: []
  field :parent_class_name, type: String
  field :starting_funds, type: Hash, default: {}

  validates :name, presence: true, uniqueness: true

  before_validation :set_defaults_from_parent_class

  def name_with_parent
    parent_class_name ? "#{parent_class_name} (#{name.downcase})" : name
  end

  def career_skills
    @career_skills ||= Skill.find(career_skill_ids)
  end

  def parent_class
    @parent_class ||= parent_class_name ? Role.find_by(name: parent_class_name) : nil
  end

  private
  def set_defaults_from_parent_class
    return unless parent_class
    self.preferred_stats = parent_class.preferred_stats if preferred_stats.empty?
    self.career_skill_ids = parent_class.career_skill_ids if career_skill_ids.empty?
    self.starting_funds = parent_class.starting_funds if starting_funds.empty?
  end
end
