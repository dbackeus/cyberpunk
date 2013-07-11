class ItemBlueprint
  include Mongoid::Document

  field :_id, type: String, default: ->{ name }

  field :name, type: String
  field :description, type: String
  field :category, type: String
  field :availability, type: String
  field :cost, type: String
  field :source, type: String

  validates :name, presence: true
end
