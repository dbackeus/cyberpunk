class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @new_membership = MembershipCreator.new(campaign: current_campaign, invitor: current_user)
  end

  def create
    @new_membership = MembershipCreator.new(membership_params)
    if @new_membership.save
      redirect_to dashboard_path, notice: "#{@new_membership.user.name} was added to the campaign!"
    else
      render :index
    end
  end

  private
  def membership_params
    params.require(:membership_creator).permit!.merge(campaign: current_campaign, invitor: current_user)
  end

  def confirmed_members
    current_campaign.memberships.select do |member|
      member.name.present?
    end.sort_by(&:name)
  end
  helper_method :confirmed_members

  def unconfirmed_members
    current_campaign.memberships.select do |member|
      member.name.blank?
    end
  end
  helper_method :unconfirmed_members
end
