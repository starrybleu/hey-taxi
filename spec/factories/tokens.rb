# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    access_token { SecureRandom.uuid.gsub(/\-/, '') }
    expired_at { 1.day.after }
  end
end
