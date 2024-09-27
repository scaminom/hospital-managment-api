class ApplicationController < ActionController::API
  include ApiResponseHandler
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActionController::RoutingError, with: :no_route_found
  rescue_from CanCan::AccessDenied, with: :unauthorized_action
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
  rescue_from ActiveRecord::InvalidForeignKey, with: :conflict_entity

  def no_route_found
    route_info = "No route matches [#{request.method}] \"#{request.original_fullpath}\""
    render_error_response(error: route_info, status: :not_found)
  end

  private

  def not_found(exception)
    render_error_response(error: format_error_message(exception), status: :not_found)
  end

  def unprocessable_entity(exception)
    render_error_response(error: format_error_message(exception), status: :unprocessable_entity)
  end

  def unauthorized_action(exception)
    render_error_response(error: format_error_message(exception), status: :forbidden)
  end

  def handle_parse_error
    render_error_response(error: 'Invalid JSON format', status: :bad_request)
  end

  def conflict_entity(exception)
    render_error_response(error: format_error_message(exception), status: :conflict)
  end

  def format_error_message(exception)
    case exception
    when ActiveRecord::RecordNotFound
      "Resource not found: #{exception.model} with ID #{exception.id}."
    when ActiveRecord::RecordInvalid
      "Validation failed: #{exception.record.errors.full_messages.join(', ')}."
    when ActiveRecord::InvalidForeignKey
      'Cannot delete the record due to a foreign key constraint. Please ensure that related records are removed first.'
    when CanCan::AccessDenied
      'You are not authorized to perform this action.'
    when ActionDispatch::Http::Parameters::ParseError
      "Invalid JSON format: #{exception.message}."
    else
      exception.message
    end
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
