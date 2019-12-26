class Token < ApplicationRecord
  belongs_to :user

  validates :access_token, :expired_at, presence: true
end
