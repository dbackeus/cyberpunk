# Assumes access to :name and :character on the mixed in model

module Mixins::Purchesable
  def self.included(base)
    base.class_eval do
      field :cost, type: Integer

      validates_numericality_of :cost

      before_create :build_transaction
      after_create :persist_transaction
    end
  end

  private
  def build_transaction
    return if cost == 0
    @transaction ||= character.transactions.build(amount: -cost, description: "Purchase of #{name}.")
  end

  def persist_transaction
    return if cost == 0
    @transaction.save!
  end
end
