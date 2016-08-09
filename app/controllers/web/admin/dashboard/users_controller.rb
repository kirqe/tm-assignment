class Web::Admin::Dashboard::UsersController < Web::Admin::AdminController
  before_action :set_user, only: [:show]
  before_action :authenticate_user
  before_filter :authorize_user
  
  def index
    @users = User.all.page params[:page]
  end

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
