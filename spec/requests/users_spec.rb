require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let(:user) { build(:user) }

  describe 'POST /api/users' do
    let(:valid_payload) { build(:user) }
    let(:invalid_payload) { { email: 'not_email', password: 'foo-bar' } }


    context 'when valid request' do
      before { post '/api/users', params: valid_payload.to_json }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      context 'but duplicate email' do
        it 'returns status code 400' do
          expect(response).to have_http_status(400)
        end

        it 'returns failure message by duplicate email' do
          expect(response.body).to match(/duplicate email/)
        end
      end
    end

    context 'when invalid request' do
      before { post '/api/users', params: invalid_payload.to_json }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns failure message by invalid email' do
        expect(response.body).to match(/invalid email/)
      end
    end
  end

end