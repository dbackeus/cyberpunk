class CharacterSkill
  include Mongoid::Document

  field :name, type: String
  field :stat, type: String
  field :custom, type: Boolean, default: false
  field :custom_description, type: String
  field :ip_multiplier, type: Integer, default: 1
  field :value, type: Integer
end
