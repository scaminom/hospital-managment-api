class VisitSerializer < Panko::Serializer
  attributes :id,
             :visit_type,
             :priority_level,
             :created_at,
             :room,
             :patient_name

  # delegate :overview, to: :object

  has_one :doctor, serializer: DoctorSerializer, only: [:id, :full_name, :speciality, :license_number]
  has_one :medical_record, serializer: MedicalRecordSerializer
  has_many :prescriptions, each_serializer: PrescriptionSerializer
  has_many :laboratory_results, each_serializer: LaboratoryResultSerializer

  def patient_name
    "#{object.patient.first_name} #{object.patient.last_name}"
  end
end
