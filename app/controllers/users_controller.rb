class UsersController < ApplicationController
  def delete_session
    sign_out current_user

    redirect_to dashboard_path
  end
end
