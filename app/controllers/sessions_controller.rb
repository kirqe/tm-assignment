class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end
  end

  def destroy
    log_out
    redirect_to tasks_path
  end
end
