module Api
  class TaxiRequestsController < ApplicationController

    def index
      render json: TaxiRequest.order('requested_at desc').all, status: :ok
    end

  end
end
