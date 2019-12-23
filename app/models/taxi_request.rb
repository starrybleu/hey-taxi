class TaxiRequest < ApplicationRecord
  validates_presence_of :passenger_id
  validates_presence_of :address
  validates_presence_of :requested_at
  validates_presence_of :driver_id
  validates_presence_of :assigned_at
end
