class DoctorRegistrationService
  def initialize(params)
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      create_doctor
      set_user_role
      save_doctor
    end
  end

  private

  def create_doctor
    @doctor = Doctor.new(@params)
  end

  def set_user_role
    @doctor.user.role = :doctor if @doctor.user
  end

  def save_doctor
    @doctor.save
    @doctor
  end
end
