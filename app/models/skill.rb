class Skill
  include Mongoid::Document

  field :name, type: String
  field :stat, type: String
  field :description, type: String
  field :ip_multiplier, type: Integer, default: 1
  field :special_ability, type: Boolean, default: false

  validates :name, :ip_multiplier, presence: true
end
