class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }

  def is_admin?
    role == "admin"
  end
end
