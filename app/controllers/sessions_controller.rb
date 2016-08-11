class SessionsController < ApplicationController

  def new
    redirect_to root_url if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].strip)
    if user && user.authenticate(params[:session][:password].strip)
      log_in user
      flash[:success] = "Logged in successfully"
      if user.is_admin?
        redirect_to admin_dashboard_tasks_path
      else
        redirect_to dashboard_user_tasks_path(user)
      end
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to dashboard_tasks_path, notice: "Logged out successfully"
  end
end
