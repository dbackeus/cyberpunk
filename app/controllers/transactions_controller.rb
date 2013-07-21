class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @transactions = character.transactions
  end

  def create
    @transaction = character.transactions.build(transaction_params)
    @transaction.save
  end

  def destroy
    @transaction = character.transactions.find(params[:id])
    @transaction.destroy
  end

  private
  def character
    @character ||= Character.editable_by(current_user).find(params[:character_id])
  end

  def transaction_params
    params.require(:transaction).permit!
  end
end
