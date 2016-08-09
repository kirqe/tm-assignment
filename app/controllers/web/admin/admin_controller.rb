class Web::Admin::AdminController < ApplicationController

  private
  def authorize_user
    redirect_to dashboard_tasks_path unless admin?
  end
end
