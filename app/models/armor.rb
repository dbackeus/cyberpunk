class Armor
  include Mongoid::Document

  def self.delegatable_fields
    @delegatable_fields ||= ArmorBlueprint.fields.keys - %w[_id _type cost]
  end

  delegatable_fields.each do |field_name|
    delegate field_name, to: :blueprint
  end

  field :cost, type: Integer

  def ev
    blueprint.ev.to_i
  end

  embedded_in :character

  belongs_to :blueprint, class_name: "ArmorBlueprint"

  validates_presence_of :blueprint
  validates_numericality_of :cost
end
