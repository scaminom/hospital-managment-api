class DoctorSerializer < Panko::Serializer
  attributes :id,
             :speciality,
             :license_number,
             :department_id

  has_one :user, serializer: UserSerializer
end
