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
    requested_token_value = extract_token
    token = Token.find_by!(access_token: requested_token_value)
    raise ExceptionHandler::InvalidTokenError, 'Expired token' if token.expired_at < DateTime.now
    token.user_id
  end

  def extract_token
    if headers[:Authorization].present?
      return headers[:Authorization].split(' ').last
    end
    raise(ExceptionHandler::InvalidTokenError, 'Missing token')
  end
end