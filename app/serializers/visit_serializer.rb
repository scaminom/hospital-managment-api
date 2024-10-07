class VisitSerializer < Panko::Serializer
  attributes :id,
             :visit_type,
             :priority_level,
             :created_at
end
