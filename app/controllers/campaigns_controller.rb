class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  def show
    campaign = current_user.campaigns.find(params[:id])
    current_user.set_current_campaign(campaign)
    redirect_to dashboard_path, notice: "Switched campaign to #{campaign.name}."
  end

  def index
    @campaigns = current_user.campaigns
  end

  def new
    @campaign = Campaign.new(creator: current_user)
  end

  def create
    @campaign = Campaign.new(campaign_parameters)
    @campaign.memberships.build(user: current_user, admin: true, referee: true)

    if @campaign.save
      current_user.set_current_campaign(@campaign)
      redirect_to dashboard_path, notice: "Created and switched to campaign #{@campaign.name}."
    else
      render :new
    end
  end

  def add_character
    character = current_user.characters.find(params[:character_id])
    current_campaign.characters << character
    redirect_to characters_path, notice: "#{character.handle} was added to the campaign!"
  end

  def remove_character
    character = current_campaign.characters.find(params[:character_id])
    current_campaign.character_ids.delete(character.id)
    character.campaign_ids.delete(current_campaign.id)
    character.save! && current_campaign.save!
    redirect_to characters_path, notice: "#{character.handle} was removed form the campaign!"
  end

  private
  def campaign_parameters
    params.require(:campaign).permit!
  end
end
