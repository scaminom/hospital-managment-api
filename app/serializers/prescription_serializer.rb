class PrescriptionSerializer < Panko::Serializer
  attributes :id,
             :medication,
             :dosage,
             :duration

  aliases created_at: :prescribed_at
end
