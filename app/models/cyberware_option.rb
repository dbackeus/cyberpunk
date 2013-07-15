class CyberwareOption
  include Mongoid::Document

  def self.form_fields
    @form_fields ||= CyberwareOptionBlueprint.fields.keys - %w[_id _type cost hl]
  end

  form_fields.each do |field_name|
    delegate field_name, to: :blueprint
  end

  field :hl, type: Integer
  field :cost, type: Integer

  embedded_in :cyberware

  belongs_to :blueprint, class_name: "CyberwareOptionBlueprint"

  validates_presence_of :blueprint

  validate :validate_option_space_limit, on: :create

  private
  def validate_option_space_limit
    if cyberware.option_limit && cyberware.options.sum(&:size) > cyberware.option_limit
      errors[:base] << "option limit exceeded"
    end
  end
end
