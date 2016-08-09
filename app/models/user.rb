class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  def is_admin?
    role == "admin"
  end
end
