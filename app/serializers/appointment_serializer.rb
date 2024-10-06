class AppointmentSerializer < Panko::Serializer
  attributes :id,
             :scheduled_time,
             :status,
             :doctor_full_name,
             :patient_full_name

  def doctor_full_name
    "Dr. #{object.doctor.user.first_name} #{object.doctor.user.last_name}"
  end

  def patient_full_name
    "#{object.patient.first_name} #{object.patient.last_name}"
  end
end
