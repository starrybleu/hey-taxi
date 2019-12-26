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


    context 'when credential is invalid' do
      context 'when password does not match' do
        let(:wrong_password_credentials) do
          {
            email: user.email,
            password: Faker::Internet.password
          }.to_json
        end
        def api_call
          post '/api/users/signin', params: wrong_password_credentials, headers: content_type_json_header
        end

        it 'returns a failure message' do
          api_call
          expect(json['message']).to match(/email and password does not match/)
        end

        it 'returns status code 403' do
          api_call
          expect(response).to have_http_status(403)
        end
      end

      context 'when user not found' do
        let(:not_existing_email_credentials) do
          {
            email: 'not_exist@email.kr',
            password: Faker::Internet.password
          }.to_json
        end
        def api_call
          post '/api/users/signin', params: not_existing_email_credentials, headers: content_type_json_header
        end

        it 'returns a failure message' do
          api_call
          expect(json['message']).to match(/Couldn't find User/)
        end

        it 'returns status code 404' do
          api_call
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end