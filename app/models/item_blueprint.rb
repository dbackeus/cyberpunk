class ItemBlueprint
  include Mongoid::Document

  field :_id, type: String, default: ->{ name }

  field :name, type: String
  field :description, type: String
  field :category, type: String
  field :availability, type: String, default: "E"
  field :cost, type: String
  field :source, type: String, default: "CP20"

  validates :name, :category, presence: true
  validates_uniqueness_of :name, scope: :_type
end
