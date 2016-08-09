class User < ApplicationRecord
  has_many :tasks
  has_secure_password

  def is_admin?
    role == "admin"
  end
end
