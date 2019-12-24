module Api
  class AuthenticationController < ApplicationController

    def authenticate
      user = User.find_by(email: auth_params[:email])
      if user&.authenticate(auth_params[:password])
        session[:user_id] = user.id
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