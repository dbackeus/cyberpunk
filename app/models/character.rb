class Character
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :editable_by, ->(user) {
    refereeing = Campaign.where("memberships.user_id" => user.id, "memberships.referee" => true).distinct(:id)
    any_of({creator_id: user.id}, {:player_ids.in => [user.id]}, {:campaign_ids.in => refereeing})
  }

  BASIC_ATTRIBUTES = %i(
    intelligence
    reflexes
    technical_ability
    cool
    attractiveness
    luck
    movement_allowance
    body_type
    empathy
  ).freeze

  belongs_to :creator, class_name: 'User', inverse_of: :characters
  belongs_to :role
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :players, class_name: "User", inverse_of: :player_characters

  embeds_many :skills, class_name: "CharacterSkill"
  accepts_nested_attributes_for :skills
  embeds_many :weapons
  accepts_nested_attributes_for :weapons

  field :sex, type: String
  field :handle, type: String

  BASIC_ATTRIBUTES.each do |attribute|
    field attribute, type: Integer, default: 2
    validates attribute, numericality: { greater_than: 1, less_than_or_equal_to: 10 }, presence: true
  end

  # Origins and personal style
  field :ethnicity, type: String
  field :clothes, type: String
  field :affections, type: String
  field :hair, type: String
  field :language, type: String

  # Family Background
  field :family_ranking, type: String
  field :parents, type: String
  field :family_status, type: String
  field :childhood_environment, type: String
  embeds_many :siblings
  accepts_nested_attributes_for :siblings, allow_destroy: true

  # Motivations
  field :personality, type: String
  field :valued_person, type: String
  field :valued_concept, type: String
  field :feelings_toward_others, type: String
  field :valued_posession, type: String

  # Life events
  field :age, type: Integer, default: 16
  embeds_many :life_events
  accepts_nested_attributes_for :life_events

  field :description, type: String

  validates :handle, :role, presence: true

  def pc?
    player_ids.any?
  end

  def npc?
    player_ids.empty?
  end

  def played_by?(user)
    player_ids.include?(user.id)
  end

  def run
    movement_allowance * 3
  end

  def leap
    run / 4
  end

  def humanity
    empathy * 10
  end

  def carry
    body_type * 10
  end

  def lift
    body_type * 40
  end

  def body_type_modifier
    case body_type
      when 2 then 0
      when 3..4 then -1
      when 5..7 then -2
      when 8..9 then -3
      when 10 then -4
      when 11 then -5
    end
  end

  private
  def assign_career_skills
    career_skills = role.career_skill_ids
    return if skills.select(&:career?).any?
    career_skills.each do |skill_id|
      skills.build(type: "career", skill_id: skill_id)
    end
  end
end
