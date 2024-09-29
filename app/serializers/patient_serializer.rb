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
             :allergies
end
