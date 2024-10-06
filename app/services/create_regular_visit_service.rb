class CreateRegularVisitService
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    raise ArgumentError, 'Cannot create emergency visit with this service' if @params[:visit_type] == 'emergency'

    Visit.new(visit_params)
  end

  private

  def visit_params
    @params.slice(:medical_record_id, :doctor_id, :appointment_id, :visit_type)
  end
end
