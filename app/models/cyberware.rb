class Cyberware
  include Mongoid::Document

  def self.delegatable_fields
    @delegatable_fields ||= CyberwareBlueprint.fields.keys - %w[_id _type cost hl]
  end

  delegatable_fields.each do |field_name|
    delegate field_name, to: :blueprint
  end

  field :hl, type: Float
  field :cost, type: Integer

  embedded_in :character

  embeds_many :options, class_name: "CyberwareOption"

  belongs_to :blueprint, class_name: "CyberwareBlueprint"

  validates_presence_of :blueprint
  validates_numericality_of :cost, :hl
end
