module Api
  class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create

    def create
      saved = User.create!(create_params)
      render json: saved, status: :created
    end

    private

    def create_params
      params.permit(:email, :password, :role, :password_confirmation)
    end
  end
end
