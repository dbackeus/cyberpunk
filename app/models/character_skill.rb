class CharacterSkill
  include Mongoid::Document

  embedded_in :character, inverse_of: :skills

  belongs_to :skill
  field :type, type: String
  field :value, type: Integer, default: 0

  validates :skill, presence: true
  validates :value, numericality: true
  validates :type, inclusion: { in: %w[career pickup chip] }

  delegate :name, :stat, :description, :ip_multiplier, :special_ability, to: :skill
end
