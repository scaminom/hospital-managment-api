class MedicalRecordSerializer < Panko::Serializer
  attributes :id,
             :notes

  has_one :anamnesis, serializer: AnamnesisSerializer
end
