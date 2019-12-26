class TaxiRequest < ApplicationRecord
  validates :passenger_id, :address, presence: true
  validates :address, length: { maximum: 100 }
end
