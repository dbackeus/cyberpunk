class CharacterSkill
  include Mongoid::Document

  embedded_in :character, inverse_of: :skills

  field :name, type: String
  field :stat, type: String
  field :custom, type: Boolean, default: false
  field :custom_description, type: String
  field :ip_multiplier, type: Integer, default: 1
  field :value, type: Integer, default: 0

  validates :value, numericality: true
end
