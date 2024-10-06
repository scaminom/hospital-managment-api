class PatientRegistrationService
  def initialize(patient_params)
    @patient_params = patient_params
  end

  def call
    ActiveRecord::Base.transaction do
      create_patient
      create_medical_record
      @patient
    end
  end

  private

  def create_patient
    @patient = Patient.create!(@patient_params)
  end

  def create_medical_record
    MedicalRecord.create!(patient: @patient)
  end
end
