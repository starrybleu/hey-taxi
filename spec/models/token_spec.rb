require 'rails_helper'

RSpec.describe Token, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:access_token) }
  it { should validate_presence_of(:expired_at) }
end
