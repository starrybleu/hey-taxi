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
end