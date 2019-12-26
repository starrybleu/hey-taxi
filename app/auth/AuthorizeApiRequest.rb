class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def authorize
    {user: user}
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find_by!(id: match_token)
  end

  def match_token
    requested_token_value = http_auth_header
    token = Token.find_by!(access_token: requested_token_value)
    raise ExceptionHandler::InvalidCredentialError, 'Expired token' if token.expired_at < DateTime.now
    token.user_id
  end

  def http_auth_header
    if headers[:Authorization].present?
      return headers[:Authorization].split(' ').last
    end
    raise(ExceptionHandler::InvalidCredentialError, 'Missing token')
  end
end