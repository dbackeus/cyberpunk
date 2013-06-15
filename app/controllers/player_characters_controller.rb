class PlayerCharactersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_referee!

  def show
    @character = current_campaign.characters.find(params[:id])
    @possible_players = current_campaign.memberships.select { |m| m.confirmed? && m.player? && !@character.player_ids.include?(m.user_id) }
  end

  def create
    character = current_campaign.characters.find(params[:character_id])
    user = current_campaign.memberships.find_by(user_id: params[:user_id]).user
    character.players << user
    redirect_to characters_path, notice: "#{user.name} was assigned as a player of #{character.handle}!"
  end

  def destroy
    character = current_campaign.characters.find(params[:id])
    user = current_campaign.memberships.find_by(user_id: params[:user_id]).user
    character.player_ids.delete(user.id)
    character.save
    redirect_to characters_path, notice: "#{user.name} is no longer playing #{character.handle}."
  end
end
