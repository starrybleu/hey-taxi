class TaxiRequest < ApplicationRecord
  validates_presence_of :passenger_id
  validates_presence_of :address
  validates_presence_of :requested_at
end
