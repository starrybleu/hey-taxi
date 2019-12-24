module Api
  class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: :authenticate

    def authenticate
      user = User.find_by!(email: auth_params[:email])
      if user.authenticate(auth_params[:password])
        session[:user_id] = user.id # todo session -> token 으로 변경해야 함
      else
        raise ExceptionHandler::InvalidCredentialError, 'email and password does not match'
      end
    end

    private

    def auth_params
      params.permit(:email, :password)
    end
  end
end