class JsonResponse
  attr_reader :success, :message, :data, :errors

  def initialize(options = {})
    @success = options[:success]
    @message = options[:message] || ''
    @data = options[:data] || []
    @errors = options[:errors] || []
  end

  def as_json(*)
    {
      success:,
      message:,
      data:,
      errors:
    }
  end
end
