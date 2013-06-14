class PagesController < ApplicationController
  def register
    redirect_to dashboard_path if user_signed_in?
  end
end
