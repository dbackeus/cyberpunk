class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: :join

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

  def destroy
    campaign = Campaign.find(params[:id])
    if campaign.membership_for(current_user).admin?
      campaign.destroy
      redirect_to campaigns_path, notice: "The campaign #{campaign.name} was destroyed!"
    else
      redirect_to campaigns_path, alert: "You're not an admin of that campaign!"
    end
  end

  def join
    campaign = Campaign.find(params[:id])
    if user_signed_in?
      if campaign.membership_for(current_user)
        redirect_to memberships_path, alert: "You are already a member of the #{campaign.name} campaign!"
      else
        campaign.memberships.create(user_id: current_user.id)
        redirect_to memberships_path, notice: "You successfully joined the #{campaign.name} campaign!"
      end
    else
      session["user_return_to"] = join_campaign_path(campaign)
      redirect_to user_google_oauth2_omniauth_authorize_path
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
