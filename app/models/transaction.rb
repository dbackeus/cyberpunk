class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :character

  field :amount, type: Integer
  field :description, type: String

  validates_numericality_of :amount
  validates_exclusion_of :amount, :in => [0], message: "can't be zero"

  after_create :add_to_character
  after_destroy :subtract_from_character

  private
  def add_to_character
    character.inc(money: amount)
  end

  def subtract_from_character
    character.inc(money: -amount)
  end
end
