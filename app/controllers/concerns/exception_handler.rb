module ExceptionHandler
  extend ActiveSupport::Concern

  class ValidationFailedError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {message: e.message}, status: :not_found
    end

    rescue_from ExceptionHandler::ValidationFailedError do |e|
      render json: {message: e.message}, status: :bad_request
    end
  end
end