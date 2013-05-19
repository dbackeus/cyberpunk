class Sibling
  include Mongoid::Document

  embedded_in :character

  field :sex, type: String
  field :age, type: String
  field :feelings, type: String
end
