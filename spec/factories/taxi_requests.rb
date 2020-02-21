# frozen_string_literal: true

FactoryBot.define do
  factory :taxi_request do
    passenger_id { Faker::Number.number }
    address { Faker::Lorem.sentence[0..100] }
    driver_id { nil }
    assigned_at { nil }
  end

  factory :already_assigned_request, parent: :taxi_request do
    passenger_id { Faker::Number.number }
    address { Faker::Lorem.sentence[0..100] }
    driver_id { 99 }
    assigned_at { '2019-12-23T10:52:18.831Z' }
  end
end
