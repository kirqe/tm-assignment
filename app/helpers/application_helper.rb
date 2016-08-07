module ApplicationHelper
  def admin?
    @current_user.role == "admin" if @current_user
  end
end
