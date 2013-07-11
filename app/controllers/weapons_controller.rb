class WeaponsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    blueprint = WeaponBlueprint.find(params[:weapon_blueprint_id])
    @weapon = character.weapons.create!(weapon_blueprint: blueprint)
  end

  def destroy
    character.weapons.find(params[:id]).destroy
  end

  private
  def character
    @character ||= Character.editable_by(current_user).find(params[:character_id])
  end
end
