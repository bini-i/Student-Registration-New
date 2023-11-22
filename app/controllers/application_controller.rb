class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      flash[:password] = "
This is your first time signing in

Please change your password
        "
      edit_user_registration_path
    else
      root_path
    end
  end
end
