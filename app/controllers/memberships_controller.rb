class MembershipsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    email = params.require(:email)
    user = User.where(email: email).first
    if user
      @membership = current_campaign.memberships.create(user: user)
      redirect_to dashboard_path, notice: "#{user.name} was added to the campaign!"
    else
      redirect_to dashboard_path, alert: "Could not find any user with email '#{email}'. Check the spelling or ask the owner of the email to register before trying again."
    end
  end
end
