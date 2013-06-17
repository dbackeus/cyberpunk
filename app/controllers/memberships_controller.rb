class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @new_membership = MembershipCreator.new(campaign: current_campaign, invitor: current_user)
  end

  def create
    @new_membership = MembershipCreator.new(membership_params)
    if @new_membership.save
      redirect_to memberships_path, notice: "A new member was added to the campaign!"
    else
      render :index
    end
  end

  def destroy
    if current_membership.admin?
      membership = current_campaign.memberships.find(params[:id])
      membership.destroy
      redirect_to memberships_path, notice: "#{membership.name} was removed from the campaign!"
    else
      redirect_to memberships_path, alert: "Only campaign admins can remove members!"
    end
  end

  def make_referee
    if current_membership.admin? || current_membership.referee?
      membership = current_campaign.memberships.find(params[:id])
      membership.update_attributes(referee: true)
      redirect_to memberships_path, notice: "#{membership.name} is now a referee!"
    else
      redirect_to memberships_path, alert: "Only campaign admins and referees can promote members!"
    end
  end

  def make_player
    if current_membership.admin? || current_membership.referee?
      membership = current_campaign.memberships.find(params[:id])
      membership.update_attributes(referee: false)
      redirect_to memberships_path, notice: "#{membership.name} is no longer a referee!"
    else
      redirect_to memberships_path, alert: "Only campaign admins and referees can demote members!"
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
