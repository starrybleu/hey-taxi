# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'POST /api/users' do
    let(:user) { build(:user) }
    let(:invalid_payload) { { email: 'not_email', password: 'foo_bar', role: 'driver' } }
    let(:valid_payload) do
      attributes_for(:user, password_confirmation: user.password)
    end

    context 'when valid request' do
      before { post '/api/users', params: valid_payload.to_json, headers: content_type_json_header }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      context 'but duplicate email' do
        let(:already_exists) { create(:already_existing_user) }
        let(:valid_payload_dup_email) do
          attributes_for(:user,
                         email: already_exists.email,
                         password: 'foo_bar', role: 'driver',
                         password_confirmation: already_exists.password)
        end

        before { post '/api/users', params: valid_payload_dup_email.to_json, headers: content_type_json_header }

        it 'returns status code 400' do
          expect(response).to have_http_status(400)
        end

        it 'returns failure message by duplicate email' do
          expect(response.body).to match(/This email is duplicated/)
        end
      end
    end

    context 'when invalid request' do
      before { post '/api/users', params: invalid_payload.to_json, headers: content_type_json_header }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns failure message by invalid email' do
        expect(response.body).to match(/Email should be correct formatted/)
      end
    end
  end
end
