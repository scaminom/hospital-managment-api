class CreateEmergencyVisitService
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    visit = Visit.new(visit_params)
    visit.visit_type = :emergency
    visit
  end

  private

  def visit_params
    @params.slice(:medical_record_id, :doctor_id, :priority_level)
  end
end
