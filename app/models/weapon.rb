class Weapon
  include Mongoid::Document

  def self.form_fields
    @form_fields ||= WeaponBlueprint.fields.keys - %w[_id _type source category]
  end

  form_fields.each do |field_name|
    delegate field_name, to: :weapon_blueprint
  end

  embedded_in :character

  belongs_to :weapon_blueprint

  validates_presence_of :weapon_blueprint
end
