class WeaponsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    @resource = character.weapons.create!(item_params)
    render "shared/item_create"
  end

  def destroy
    @resource = character.weapons.find(params[:id])
    @resource.destroy
    render "shared/item_destroy"
  end

  private
  def character
    @character ||= Character.editable_by(current_user).find(params[:character_id])
  end

  def item_params
    params.require(:item).permit!
  end
end
