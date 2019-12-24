class TaxiRequest < ApplicationRecord
  validates :passenger_id, :address, presence: true
end
