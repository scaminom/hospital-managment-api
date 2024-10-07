class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  has_one :visit

  enum :status, {
    scheduled:   0,
    in_progress: 1,
    completed:   2,
    cancelled:   3,
    no_show:     4
  }

  validates :scheduled_time, presence: true
  validate :scheduled_time_cannot_be_in_the_past
  validate :doctor_availability
  validate :no_conflicting_appointments

  BUFFER_TIME = 30.minutes

  WHITELISTED_ATTRIBUTES = %i[
    patient_id
    doctor_id
    scheduled_time
    status
  ].freeze

  private

  def scheduled_time_cannot_be_in_the_past
    errors.add(:scheduled_time, :past_date) if scheduled_time.present? && scheduled_time < Time.current
  end

  def doctor_availability
    return unless doctor.present? && scheduled_time.present?

    conflicting_appointments = doctor.appointments
                                     .where(scheduled_time: (scheduled_time - BUFFER_TIME..scheduled_time + BUFFER_TIME))
                                     .where.not(id:)
    errors.add(:base, :doctor_unavailable) if conflicting_appointments.exists?
  end

  def no_conflicting_appointments
    return unless patient.present? && scheduled_time.present?

    conflicting_appointments = patient.appointments
                                      .where.not(id:)
                                      .where(scheduled_time: (scheduled_time - BUFFER_TIME..scheduled_time + BUFFER_TIME))
    errors.add(:scheduled_time, :conflicting_appointment) if conflicting_appointments.exists?
  end
end
