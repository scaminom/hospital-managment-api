module ApiExceptionsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveModel::ValidationError, ActiveRecord::RecordInvalid, ArgumentError, with: :handle_validation_error
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from ActionController::RoutingError, with: :handle_no_route_found
    rescue_from CanCan::AccessDenied, with: :handle_unauthorized_action
    rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
    rescue_from ActiveRecord::InvalidForeignKey, with: :handle_conflict_entity
    rescue_from ActiveRecord::RecordNotUnique, with: :handle_record_not_unique
    rescue_from AbstractController::ActionNotFound, with: :handle_action_not_found
    rescue_from ActionController::UnpermittedParameters, with: :handle_unpermitted_parameters
  end

  def format_error_message(exception)
    exception.respond_to?(:record) ? exception.record.errors.full_messages : exception.message
  end

  def handle_not_found(exception)
    render_error_response(error: exception, status: :not_found)
  end

  def handle_validation_error(exception)
    render_error_response(error: exception, status: :unprocessable_entity)
  end

  def handle_parameter_missing(exception)
    render_error_response(error: exception.message, status: :bad_request)
  end

  def handle_no_route_found
    render_error_response(error: "No route matches [#{request.method}] \"#{request.original_fullpath}\"", status: :not_found)
  end

  def handle_unauthorized_action(exception)
    render_error_response(error: exception, status: :forbidden)
  end

  def handle_parse_error
    render_error_response(error: 'Invalid JSON format', status: :bad_request)
  end

  def handle_conflict_entity(exception)
    render_error_response(error: exception, status: :conflict)
  end

  def handle_record_not_unique(exception)
    render_error_response(error: exception, status: :conflict, message: 'Record already exists.')
  end

  def handle_action_not_found(exception)
    render_error_response(error: format_error_message(exception), status: :not_found)
  end

  def handle_standard_error(exception)
    log_exception(exception) unless Rails.env.test?
    render_error_response(error: 'An unexpected error occurred', status: :internal_server_error)
  end

  def handle_unpermitted_parameters(exception)
    render_error_response(error: exception, status: :bad_request)
  end

  def log_exception(exception)
    Rails.logger.error "#{exception.class}: #{exception.message}"
    Rails.logger.error exception.backtrace.join("\n")
  end
end
