class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(*)
    new_user_session_path
  end

  protected 

  def permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password])
  end
end
