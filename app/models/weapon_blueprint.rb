class WeaponBlueprint < ItemBlueprint
  include Mongoid::Document

  field :type, type: String
  field :accuracy, type: String
  field :concealability, type: String
  field :damage, type: String
  field :ammo, type: String
  field :shots, type: String
  field :rof, type: String
  field :reliability, type: String
  field :range, type: String

  validates :type, presence: true
end
