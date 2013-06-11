class CharacterSkill
  include Mongoid::Document

  embedded_in :character, inverse_of: :skills

  field :name, type: String
  field :stat, type: String
  field :custom, type: Boolean, default: false
  field :custom_description, type: String
  field :ip_multiplier, type: Integer, default: 1
  field :special_ability, type: Boolean, default: false
  field :type, type: String
  field :value, type: Integer, default: 0

  validates :name, :ip_multiplier, presence: true
  validates :value, numericality: true
  validates :type, inclusion: { in: %w[career pickup chip] }

  def custom=(value)
    write_attribute(:custom, boolean(value))
  end

  def special_ability=(value)
    write_attribute(:special_ability, boolean(value))
  end

  private
  def boolean(booleanish)
    booleanish == true || booleanish == "true"
  end
end
