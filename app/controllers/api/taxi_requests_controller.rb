module Api
  class TaxiRequestsController < ApplicationController

    def index
      render json: TaxiRequest.order('created_at desc').all, status: :ok
    end

    def create
      raise ExceptionHandler::ValidationFailedError,
            "Validation failed: address's length should be less than 100" if taxi_request_params['address'].length > 100
      saved = TaxiRequest.create!(taxi_request_params)
      render json: saved, status: :created
    end

    private

    def taxi_request_params
      params.permit(:passenger_id, :address)
    end

  end
end
