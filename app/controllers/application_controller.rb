class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    # todo session -> token 으로 변경
    @current_user = User.find_by(id: session[:user_id])
  end
end
