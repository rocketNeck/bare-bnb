class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description, :email, :password])
    end


    #TODO: need to set up app id and secret for Facebook login and google login
    #TODO: modify image uploads to use cloudinery for cloud image host
    #####  it will neeed to send image to cloud and have reference to save to model  @user.image or @room.image
end
