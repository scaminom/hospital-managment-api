class LaboratoryResultSerializer < Panko::Serializer
  attributes :id,
             :lab_type,
             :name,
             :results,
             :status

  aliases created_at: :performed_at
end
