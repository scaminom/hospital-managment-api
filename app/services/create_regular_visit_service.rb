class CreateRegularVisitService
  def self.call(params, appointment_status)
    new(params, appointment_status).call
  end

  def initialize(params, appointment_status)
    @params = params
    @appointment_status = appointment_status
  end

  def call
    raise ArgumentError, 'Cannot create regular visit with this service' if @params[:visit_type] == 'regular'

    visit = Visit.new(visit_params)
    visit.update_appointment_status(@appointment_status)
    visit
  end

  private

  def visit_params
    @params.slice(:medical_record_id, :doctor_id, :appointment_id, :visit_type)
  end
end
