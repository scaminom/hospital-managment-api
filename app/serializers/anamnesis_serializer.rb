class AnamnesisSerializer < Panko::Serializer
  attributes :id,
             :current_residence,
             :education_level,
             :occupation,
             :marital_status,
             :religion,
             :handedness,
             :family_reference,
             :gender_identity,
             :medical_history,
             :age

  def age
    object.patient.age
  end
end
