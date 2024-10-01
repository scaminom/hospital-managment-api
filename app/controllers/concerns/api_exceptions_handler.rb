module ApiExceptionsHandler
  extend ActiveSupport::Concern

  included do
    around_action :handle_exceptions
  end

  def handle_exceptions
    yield
  rescue ActiveRecord::RecordNotFound => e
    handle_record_not_found(e)
  rescue ActiveModel::ValidationError, ActiveRecord::RecordInvalid, ArgumentError => e
    handle_validation_error(e)
  rescue ActionController::ParameterMissing => e
    handle_parameter_missing(e)
  rescue ActionController::RoutingError => e
    handle_no_route_found(e)
  rescue CanCan::AccessDenied => e
    handle_unauthorized_action(e)
  rescue ActionDispatch::Http::Parameters::ParseError => e
    handle_parse_error(e)
  rescue ActiveRecord::InvalidForeignKey => e
    handle_conflict_entity(e)
  rescue ActiveRecord::RecordNotUnique => e
    handle_record_not_unique(e)
  rescue StandardError => e
    handle_standard_error(e)
  rescue AbstractController::ActionNotFound => e
    handle_action_not_found(e)
  end

  private

  def handle_action_not_found(exception)
    render_error_response(error: format_error_message(exception), status: 404)
  end

  def handle_record_not_found(exception)
    render_error_response(error: format_error_message(exception), status: 404)
  end

  def handle_validation_error(exception)
    render_error_response(error: format_error_message(exception), status: 422)
  end

  def handle_parameter_missing(exception)
    render_error_response(error: exception.message, status: 400)
  end

  def handle_no_route_found(_exception)
    route_info = "No route matches [#{request.method}] \"#{request.original_fullpath}\""
    render_error_response(error: [route_info], status: 404)
  end

  def handle_unauthorized_action(exception)
    render_error_response(error: format_error_message(exception), status: 403)
  end

  def handle_parse_error(_exception)
    render_error_response(error: 'Invalid JSON format', status: 400)
  end

  def handle_conflict_entity(exception)
    render_error_response(error: format_error_message(exception), status: 409)
  end

  def handle_record_not_unique(exception)
    render_error_response(error: format_error_message(exception), status: 409, message: 'Record already exists.')
  end

  def handle_standard_error(exception)
    log_exception(exception) unless Rails.env.test?
    render_error_response(error: exception.message, status: 500)
  end

  def log_exception(exception)
    Rails.logger.error exception.class.to_s
    Rails.logger.error exception.to_s
    Rails.logger.error exception.backtrace.join("\n")
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
    when AbstractController::ActionNotFound
      "Action not found: #{exception.message}."
    else
      exception.message
    end
  end
end
