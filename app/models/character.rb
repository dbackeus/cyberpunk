class Character
  include Mongoid::Document

  BASIC_ATTRIBUTES = %i(
    intelligence
    reflexes
    cool
    technical_ability
    luck
    attractiveness
    movement_allowance
    empathy
    body_type
  ).freeze

  BASIC_ATTRIBUTES.each do |attribute|
    field attribute, type: Integer, default: 2
    validates attribute, numericality: { greater_than: 1, less_than_or_equal_to: 10 }
  end
end
