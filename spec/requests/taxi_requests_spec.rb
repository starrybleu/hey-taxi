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
      let!(:sorted_requests) { taxi_requests.sort_by { |r| r.created_at }.reverse }
      let!(:old_request) { sorted_requests.last }
      let!(:recent_request) { sorted_requests.first }

      it 'created_at desc' do
        expect(json[0]['created_at']).to eq(recent_request.created_at.strftime("%FT%T.%LZ"))
        expect(json[LIST_SIZE - 1]['created_at']).to eq(old_request.created_at.strftime("%FT%T.%LZ"))
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/taxi-requests' do
    let(:valid_payload) { {passenger_id: 44, address: '서울특별시 강남구 테헤란로'} }
    let(:invalid_payload) { {passenger_id: 44, address: Faker::String.random(length: 101)} }

    context 'when the request is valid' do
      before { post '/api/taxi-requests', params: valid_payload }

      it 'creates a tax-request' do
        expect(json['address']).to eq('서울특별시 강남구 테헤란로')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

    end

    context 'when the requested address has invalid length over 100' do
      before { post '/api/taxi-requests', params: invalid_payload }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: address's length should be less than 100/)
      end
    end
  end

  describe 'PUT /api/taxi-requests/:id' do
    let(:taxi_request_id) { taxi_requests.first.id }
    let(:valid_payload) { {driver_id: taxi_requests.last.id} } # todo 인증이 추가되면, valid_payload 는 필요없어질 것이다.
    let(:not_exist_taxi_request_id) { taxi_requests.last.id + 1 }

    context 'when the record exists' do
      before { put "/api/taxi-requests/#{taxi_request_id}", params: valid_payload }

      it 'updates the record' do
        expect(json['driver_id']).to eq(valid_payload['driver_id'])
      end

    end

    context 'when the record does not exist' do
      before { put "/api/taxi-requests/#{not_exist_taxi_request_id}", params: valid_payload }

    end
  end

end