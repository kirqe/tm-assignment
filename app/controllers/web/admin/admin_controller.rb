class Web::Admin::AdminController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_admin!


  private
  def ensure_admin!
    unless @current_user && admin?
      redirect_to dashboard_tasks_path
    end
  end
end
