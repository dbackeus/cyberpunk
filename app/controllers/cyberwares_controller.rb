class CyberwaresController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    @resource = character.cyberwares.create!(params.require(:item).permit!)
    render "shared/item_create"
  end

  def destroy
    @resource = character.cyberwares.find(params[:id])
    @resource.destroy
    render "shared/item_destroy"
  end

  private
  def character
    @character ||= Character.editable_by(current_user).find(params[:character_id])
  end
end
