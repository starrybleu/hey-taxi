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
      let!(:old_request) { taxi_requests.sort_by { |r| r.requested_at }.reverse.last }
      let!(:recent_request) { taxi_requests.sort_by { |r| r.requested_at }.reverse.first }

      it 'requested_at desc' do
        requested_at_list_from_json = json.map { |r| r["requested_at"].to_s }

        expect(requested_at_list_from_json[0]).to eq(recent_request.requested_at.strftime("%FT%T.%LZ"))
        expect(requested_at_list_from_json[LIST_SIZE - 1]).to eq(old_request.requested_at.strftime("%FT%T.%LZ"))
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end
end