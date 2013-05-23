class LifeEvent
  include Mongoid::Document

  embedded_in :character

  field :description, type: String
end
