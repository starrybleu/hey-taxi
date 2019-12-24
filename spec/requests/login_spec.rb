require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'POST /api/users/signin (login)' do
    let(:user) { create(:user) }
    let(:valid_credentials) do
      {
          email: user.email,
          password: user.password
      }.to_json
    end

    context 'when credential is valid' do
      before { post '/api/users/signin', params: valid_credentials, headers: content_type_json_header }

      it 'returns a session id in response header' do
        expect(response.headers['Set-Cookie']).to match(/_hey_taxi_session/)
      end
    end

  end
end