
module SpecHelpers
  # def login_as_admin
  #   admin = FactoryGirl.create(:admin_user)
  #   login_as(admin)
  # end

  def login_as(user)
    request.session[:user_id] = user.id
  end
end
