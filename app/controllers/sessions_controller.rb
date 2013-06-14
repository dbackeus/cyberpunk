class SessionsController < ApplicationController
  def destroy
    sign_out_and_redirect(current_user)
  end
end
