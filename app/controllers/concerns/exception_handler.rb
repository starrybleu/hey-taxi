module ExceptionHandler
  extend ActiveSupport::Concern

  class ValidationFailedError < StandardError
  end
  class UnprocessableError < StandardError
  end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ExceptionHandler::ValidationFailedError do |e|
      render json: { message: e.message }, status: :bad_request
    end

    rescue_from ExceptionHandler::UnprocessableError do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end