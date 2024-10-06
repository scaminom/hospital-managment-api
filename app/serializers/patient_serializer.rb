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
             :medical_record_id

  def medical_record_id
    object.medical_record&.id
  end
end
