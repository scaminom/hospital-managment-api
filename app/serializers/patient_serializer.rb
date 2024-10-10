class PatientSerializer < Panko::Serializer
  attributes :id,
             :insurance_number,
             :first_name,
             :last_name,
             :date_of_birth,
             :gender,
             :address,
             :phone_number,
             :email,
             :blood_type,
             :allergies,
             :medical_record_id,
             :birth_place,
             :full_name

  def medical_record_id
    object.medical_record&.id
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
