class VisitFactory
  def self.create(type, params)
    case type.to_sym
    when :regular
      create_regular_visit(params)
    when :emergency
      create_emergency_visit(params)
    else
      raise ArgumentError, "Invalid visit type: #{type}"
    end
  end

  def self.create_regular_visit(params)
    ActiveRecord::Base.transaction do
      visit = Visit.new(params.except(:appointment_status))
      visit.visit_type = params[:visit_type] || :routine_checkup
      update_appointment_status(visit, params[:appointment_status])
      visit
    end
  end

  def self.create_emergency_visit(params)
    visit = Visit.new(params)
    visit.visit_type = :emergency
    visit
  end

  def self.update_appointment_status(visit, status)
    visit.appointment.update(status:) if visit.appointment && status.present?
  end
end
