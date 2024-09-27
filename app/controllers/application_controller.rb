class ApplicationController < ActionController::API
  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
