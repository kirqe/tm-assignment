class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  



  protected
  def authenticate_user
    unless logged_in?
      redirect_to login_path
    end
  end
end
