class JwtDecoder
  def initialize(token)
    @token = token
  end

  def valid?
    JWT.decode(@token, nil, false)
    true
  rescue JWT::DecodeError
    false
  end

  def decode
    return nil unless valid?

    JWT.decode(
      @token,
      Rails.application.credentials.devise[:jwt_secret_key]
    ).first
  rescue JWT::DecodeError
    nil
  end
end

