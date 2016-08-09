class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  protect_from_forgery with: :exception



  private
  def authenticate_user
    unless logged_in?
      redirect_to login_path
    end
  end

end
