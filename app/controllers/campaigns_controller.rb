class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @campaign = Campaign.new(creator: current_user)
  end

  def create
    @campaign = Campaign.new(campaign_parameters)
    @campaign.memberships.build(user: current_user, admin: true, referee: true)

    if @campaign.save
      redirect_to dashboard_path, notice: "Campaign created!"
    else
      render :new
    end
  end

  private
  def campaign_parameters
    params.require(:campaign).permit!
  end
end
