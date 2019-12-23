FactoryBot.define do
  factory :taxi_request do
    passenger_id { Faker::Number.number }
    address { Faker::Lorem.sentence[0..100] }
    driver_id { Faker::Number.number }
    assigned_at { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all)}
  end
end