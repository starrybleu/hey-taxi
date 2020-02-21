# frozen_string_literal: true

module Api
  class TaxiRequestsController < ApplicationController

    def index
      render json: TaxiRequest.order('created_at desc').all, status: :ok
    end

    def create
      saved = TaxiRequest.create!(taxi_request_params)
      render json: saved, status: :created
    end

    def update
      taxi_request = TaxiRequest.find(params[:id])

      raise ExceptionHandler::UnprocessableError, 'Already assigned' unless taxi_request.driver_id.nil?

      taxi_request.update!(driver_id: current_user.id, assigned_at: DateTime.now)
      render json: taxi_request, status: :ok
    end

    private

    def taxi_request_params
      params.permit(:passenger_id, :address)
    end
  end
end
