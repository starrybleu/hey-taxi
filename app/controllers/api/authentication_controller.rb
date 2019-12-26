# frozen_string_literal: true

module Api
  class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: :authenticate

    def authenticate
      user = User.find_by!(email: auth_params[:email])
      if user.authenticate(auth_params[:password])
        token = Token.create!(user_id: user.id, access_token: SecureRandom.uuid.gsub(/\-/, ''), expired_at: 1.day.after)
        return render json: token.as_json(only: %i(access_token expired_at)), status: :ok
      end
      raise ExceptionHandler::InvalidCredentialError, 'email and password does not match'
    end

    private

    def auth_params
      params.permit(:email, :password)
    end
  end
end
