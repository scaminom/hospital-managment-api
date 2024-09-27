# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(_current_user, _opts = {})
          render json: {
            token: current_token
          }
        end

        def respond_to_on_destroy
          token = request.headers['Authorization']&.split&.last
          jwt_payload = JwtDecoder.new(token).decode if token
          current_user = User.find(jwt_payload['sub']) if jwt_payload

          if current_user
            render json: {
              status:  200,
              message: 'Logged out successfully.'
            }
          else
            render json: {
              status:  401,
              message: "Token can't be found."
            }
          end
        end
      end
    end
  end
end
