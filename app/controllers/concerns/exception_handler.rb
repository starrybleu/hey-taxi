# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class ValidationFailedError < StandardError
  end
  class UnprocessableError < StandardError
  end
  class InvalidCredentialError < StandardError
  end
  class InvalidTokenError < StandardError
  end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      # TODO: if~elsif-else 구문을 개선하자. re-raise 가 가능하면 될 것 같은데, 여기서 다시 exception 을 raise 하면 컨텍스트가 밖으로 빠져나간다.
      if /Validation failed: Email is invalid/.match(e.message)
        render(json: { message: 'Email should be correct formatted' }, status: :bad_request)
      elsif /Validation failed: Email has already been taken/.match(e.message)
        render(json: { message: 'This email is duplicated' }, status: :bad_request)
      elsif /Validation failed: Address is too long \(maximum is 100 characters\)/.match(e.message)
        render(json: { message: "Validation failed: address's length should be less than 100" }, status: :bad_request)
      else
        render json: { message: e.message }, status: :unprocessable_entity
      end
    end

    rescue_from ExceptionHandler::ValidationFailedError, with: :bad_request

    rescue_from ExceptionHandler::UnprocessableError do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from ExceptionHandler::InvalidCredentialError do |e|
      render json: { message: e.message }, status: :forbidden
    end

    rescue_from ExceptionHandler::InvalidTokenError, with: :unauthorized_request
  end

  private

  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end

  def bad_request(e)
    render json: { message: e.message }, status: :bad_request
  end
end
