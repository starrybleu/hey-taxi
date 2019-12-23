module Api
  class TaxiRequestsController < ApplicationController

    def index
      render json: TaxiRequest.order('requested_at desc').all, status: :ok
    end

    def create
      raise ExceptionHandler::ValidationFailedError,
            "Validation failed: address's length should be less than 100" if taxi_request_params['address'].length > 100

      rest_attributes = {'requested_at': DateTime.now}
      saved = TaxiRequest.create!(taxi_request_params.merge(rest_attributes))
      render json: saved, status: :created
    end

    private

    def taxi_request_params
      params.permit(:passenger_id, :address)
    end

  end
end
