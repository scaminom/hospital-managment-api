class DoctorSerializer < Panko::Serializer
  attributes :id,
             :speciality,
             :license_number

  has_one :user, serializer: UserSerializer
  has_one :department, serializer: DepartmentSerializer
end
