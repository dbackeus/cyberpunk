class Weapon
  include Mongoid::Document
  include Mixins::Purchesable

  def self.delegatable_fields
    @delegatable_fields ||= WeaponBlueprint.fields.keys - %w[_id _type cost]
  end

  delegatable_fields.each do |field_name|
    delegate field_name, to: :blueprint
  end

  embedded_in :character

  belongs_to :blueprint, class_name: "WeaponBlueprint"

  validates_presence_of :blueprint
end
