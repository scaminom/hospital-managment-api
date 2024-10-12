class LaboratoryResultSerializer < Panko::Serializer
  attributes :id,
             :lab_type,
             :name,
             :results,
             :status,
             :visit_id

  aliases created_at: :performed_at
end
