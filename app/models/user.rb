# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :password_digest, :role, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
