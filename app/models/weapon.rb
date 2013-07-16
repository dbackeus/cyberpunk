class Weapon
  include Mongoid::Document

  def self.delegatable_fields
    @delegatable_fields ||= WeaponBlueprint.fields.keys - %w[_id _type cost]
  end

  delegatable_fields.each do |field_name|
    delegate field_name, to: :blueprint
  end

  field :cost, type: Integer

  embedded_in :character

  belongs_to :blueprint, class_name: "WeaponBlueprint"

  validates_presence_of :blueprint
  validates_numericality_of :cost
end
