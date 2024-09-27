class JwtDecoder
  def initialize(token)
    @token = token
  end

  def decode
    JWT.decode(@token, Rails.application.credentials.devise[:jwt_secret_key]).first
  rescue JWT::DecodeError
    nil
  end
end
