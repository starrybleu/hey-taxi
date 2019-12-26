# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'foo_bar' }
    role { 'passenger' }
  end

  factory :already_existing_user, parent: :user do
    email { 'duplicate@email.com' }
    password { 'foo_bar' }
    role { 'passenger' }
  end
end
