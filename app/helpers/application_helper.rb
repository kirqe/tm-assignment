module ApplicationHelper
  def admin?
    @current_user.role == "admin"
  end
end
