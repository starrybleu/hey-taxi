# frozen_string_literal: true
module Api
  class TaxiRequestsController < ApplicationController

    def index
      render json: TaxiRequest.order('created_at desc').all, status: :ok
    end

    def create
      if taxi_request_params['address'].length > 100
        raise ExceptionHandler::ValidationFailedError,
              "Validation failed: address's length should be less than 100"
      end
      saved = TaxiRequest.create!(taxi_request_params)
      render json: saved, status: :created
    end

    def update
      taxi_request = TaxiRequest.find(params[:id])

      raise ExceptionHandler::UnprocessableError, 'Already assigned' unless taxi_request.driver_id.nil?

      taxi_request.update!(update_params.merge(assigned_at: DateTime.now))
      render json: taxi_request, status: :ok
    end

    private

    def taxi_request_params
      params.permit(:passenger_id, :address)
    end

    def update_params
      params.permit(:driver_id) # todo 인증 붙이면 driver_id 필요 없음
    end

  end
end
