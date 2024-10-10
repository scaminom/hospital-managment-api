class DoctorSerializer < Panko::Serializer
  attributes :id,
             :speciality,
             :license_number,
             :full_name

  has_one :user, serializer: UserSerializer
  has_one :department, serializer: DepartmentSerializer

  def full_name
    "#{object.user.first_name} #{object.user.last_name}"
  end
end
