module ApiResponseHandler
  extend ActiveSupport::Concern

  def json_response(options = {}, status = 500)
    render json: JsonResponse.new(options), status:
  end

  def render_error_response(error:, status: 422, message: '')
    json_response({
                    success: false,
                    message:,
                    errors:  error
                  }, status)
  end

  def render_success_response(data: {}, message: '', status: 200)
    json_response({
                    success: true,
                    message:,
                    data:
                  }, status)
  end
end
