class ArmorsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    @armor = character.armors.create!(params.require(:item).permit!)
  end

  def destroy
    character.armors.find(params[:id]).destroy
  end

  private
  def character
    @character ||= Character.editable_by(current_user).find(params[:character_id])
  end
end
