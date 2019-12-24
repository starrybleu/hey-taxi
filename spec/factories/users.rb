FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'foo_bar' }
    type { 'passenger' }
  end
end