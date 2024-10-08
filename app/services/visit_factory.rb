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
    visit = Visit.new(params)
    visit.visit_type = params[:visit_type] || :routine_checkup
    visit
  end

  def self.create_emergency_visit(params)
    visit = Visit.new(params)
    visit.visit_type = :emergency
    visit
  end
end
