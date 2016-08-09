class Web::Admin::AdminController < ApplicationController
  include SessionsHelper
  before_filter :authenticate_user
  before_filter :authorize_user


  protected
  def authorize_user
    redirect_to dashboard_tasks_path unless @current_user.is_admin?
  end
end
