# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json
        before_action :configure_permitted_parameters, if: :devise_controller?

        def create
          build_resource(sign_up_params)

          if resource.save
            sign_up(resource_name, resource)
            respond_with
          else
            handle_invalid_signup
          end
        end

        private

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: User::WHITELISTED_ATTRIBUTES_REGISTRATION)
        end

        def respond_with
          render_success_response(
            message: 'Signed up successfully',
            data:    {
              token: current_token
            },
            status:  :created
          )
        end

        def handle_invalid_signup
          render_error_response(
            message: 'User could not be created successfully',
            errors:  resource.errors.full_messages,
            status:  :unprocessable_entity
          )
        end
      end
    end
  end
end

