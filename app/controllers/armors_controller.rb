class ArmorsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    blueprint = ArmorBlueprint.find(params[:blueprint_id])
    @armor = character.armors.create!(blueprint: blueprint)
  end

  def destroy
    character.armors.find(params[:id]).destroy
  end

  private
  def character
    @character ||= Character.editable_by(current_user).find(params[:character_id])
  end
end
