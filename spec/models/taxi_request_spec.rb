require 'rails_helper'

RSpec.describe TaxiRequest, type: :model do
  it { should validate_presence_of(:passenger_id) }
  it { should validate_presence_of(:address) }
end
