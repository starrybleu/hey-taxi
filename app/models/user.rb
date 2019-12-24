class User < ApplicationRecord
  has_secure_password

  validates :email, :password_digest, :type, presence: true
end
