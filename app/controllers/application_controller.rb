class ApplicationController < ActionController::API
  include ApiResponseHandler
  include ApiExceptionsHandler

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
