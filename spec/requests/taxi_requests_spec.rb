require 'rails_helper'

LIST_SIZE = 10

RSpec.describe 'TaxiRequest API', type: :request do
  let!(:taxi_requests) { create_list(:taxi_request, LIST_SIZE) }

  describe 'GET /api/taxi-requests' do
    before { get '/api/taxi-requests' }

    it 'returns taxi-requests' do
      expect(json).not_to be_empty
      expect(json.size).to eq(LIST_SIZE)
    end

    context 'sorted by' do
      let!(:sorted_requests) { taxi_requests.sort_by { |r| r.requested_at }.reverse }
      let!(:old_request) { sorted_requests.last }
      let!(:recent_request) { sorted_requests.first }

      it 'requested_at desc' do
        expect(json[0]['requested_at']).to eq(recent_request.requested_at.strftime("%FT%T.%LZ"))
        expect(json[LIST_SIZE - 1]['requested_at']).to eq(old_request.requested_at.strftime("%FT%T.%LZ"))
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/taxi-requests' do
    let(:valid_payload) { {address: '서울특별시 강남구 테헤란로'} }

    context 'when the request is valid' do
      before { post '/api/taxi-requests', params: valid_payload }

      it 'creates a tax-request' do
        expect(json['address']).to eq('서울특별시 강남구 테헤란로')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the requested address has invalid length over 100' do
      before { post '/api/taxi-requests', params: {address: Faker::Lorem.characters(101)} }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end


  end

end