module Api
  class TaxiRequestsController < ApplicationController

    def index
      render json: TaxiRequest.all, status: :ok
    end

  end
end
