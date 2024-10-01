# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < Devise::SessionsController
        prepend_before_action :allow_params_authentication!, only: :create

        respond_to :json

        def create
          resource = warden.authenticate(auth_options)

          if resource
            respond_with
          else
            handle_invalid_login
          end
        end

        def destroy
          token = extract_token_from_header
          return handle_missing_token if token.nil?

          decoder = JwtDecoder.new(token)
          return handle_invalid_token unless decoder.valid?

          jwt_payload = decoder.decode
          return handle_invalid_token if jwt_payload.nil?

          current_user = find_user(jwt_payload)
          return handle_user_not_found if current_user.nil?

          sign_out(current_user)
          handle_successful_logout
        end

        protected

        def auth_options
          { scope: resource_name, recall: "#{controller_path}#create" }
        end

        private

        def respond_with
          render_success_response(
            data:    {
              user: {
                token: current_token
              }
            },
            message: 'Logged in successfully.',
            status:  :ok
          )
        end

        def handle_invalid_login
          render_error_response(
            error:   ['Invalid email or password'],
            message: 'Authentication failed. Please check your credentials and try again.',
            status:  :unauthorized
          )
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
