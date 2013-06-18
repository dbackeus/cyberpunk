class Skill
  include Mongoid::Document

  field :name, type: String
  field :short, type: String
  field :stat, type: String
  field :description, type: String
  field :ip_multiplier, type: Integer, default: 1
  field :special_ability, type: Boolean, default: false

  validates :name, presence: true, uniqueness: true
  validates :ip_multiplier, presence: true
  validates_length_of :short, maximum: 20, allow_nil: true
end
