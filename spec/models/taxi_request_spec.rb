require 'rails_helper'

RSpec.describe TaxiRequest, type: :model do
  it { should validate_presence_of(:passenger_id) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:requested_at) }
  it { should validate_presence_of(:driver_id) }
  it { should validate_presence_of(:assigned_at) }
end
