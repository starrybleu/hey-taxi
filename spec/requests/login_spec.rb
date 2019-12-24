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
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    context 'when credential is valid' do
      before { post '/api/users/signin', params: valid_credentials, headers: content_type_json_header }

      it 'returns a session id in response header' do
        expect(response.headers['Set-Cookie']).to match(/_hey_taxi_session/)
      end
    end


    context 'when credential is invalid' do
      before { post '/api/users/signin', params: invalid_credentials, headers: content_type_json_header }

      it 'returns a failure message' do
        expect(json['message']).to match(/email and password does not match/)
      end

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end
  end
end