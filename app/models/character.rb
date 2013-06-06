class Character
  include Mongoid::Document
  include Mongoid::Timestamps

  BASIC_ATTRIBUTES = %i(
    intelligence
    reflexes
    cool
    technical_ability
    luck
    attractiveness
    movement_allowance
    empathy
    body_type
  ).freeze

  belongs_to :role

  embeds_many :skills, class_name: "CharacterSkill"
  accepts_nested_attributes_for :skills

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
  accepts_nested_attributes_for :siblings

  # Motivations
  field :personality, type: String
  field :valued_person, type: String
  field :valued_concept, type: String
  field :valued_posession, type: String
  field :feelings_toward_others, type: String

  # Life events
  field :age, type: Integer
  embeds_many :life_events
  accepts_nested_attributes_for :life_events

  validates :handle, :role, presence: true

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
end
