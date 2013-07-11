class Armor
  include Mongoid::Document

  def self.form_fields
    @form_fields ||= ArmorBlueprint.fields.keys - %w[_id _type source category]
  end

  form_fields.each do |field_name|
    delegate field_name, to: :armor_blueprint
  end

  embedded_in :character

  belongs_to :armor_blueprint

  validates_presence_of :armor_blueprint
end
