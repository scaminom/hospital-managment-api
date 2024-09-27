# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(_current_user, _opts = {})
          render_success_response(data: { token: current_token })
        end

        def respond_to_on_destroy
          token = extract_token_from_header
          return handle_missing_token if token.nil?

          decoder = JwtDecoder.new(token)
          return handle_invalid_token unless decoder.valid?

          jwt_payload = decoder.decode
          return handle_invalid_token if jwt_payload.nil?

          current_user = find_user(jwt_payload)
          return handle_user_not_found if current_user.nil?

          handle_successful_logout
        end

        def extract_token_from_header
          request.headers['Authorization']&.split&.last
        end

        def find_user(jwt_payload)
          User.find_by(id: jwt_payload['sub'])
        end

        def handle_missing_token
          render_error_response(
            error:   { token: 'Missing token' },
            message: 'Authorization token is missing.',
            status:  :unauthorized
          )
        end

        def handle_invalid_token
          render_error_response(
            error:   { token: 'Invalid token' },
            message: 'Token is invalid or has expired.',
            status:  :unauthorized
          )
        end

        def handle_user_not_found
          render_error_response(
            error:   { user: 'User not found' },
            message: "User associated with the token doesn't exist.",
            status:  :not_found
          )
        end

        def handle_successful_logout
          render_success_response(message: 'Logged out successfully.')
        end
      end
    end
  end
end
