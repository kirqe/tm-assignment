class Web::Admin::AdminController < ApplicationController

  before_filter :authenticate_user
  before_filter :authorize_user


  protected
  def authorize_user
    redirect_to dashboard_tasks_path unless admin?
  end
end
