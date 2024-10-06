class Visit < ApplicationRecord
  belongs_to :medical_record
  belongs_to :doctor
  belongs_to :appointment, optional: true

  enum :visit_type, {
    routine_checkup:         0,
    follow_up:               1,
    emergency:               2,
    specialist_consultation: 3
  }

  enum :priority_level, {
    low:    0,
    medium: 1,
    high:   2,
    urgent: 3
  }

  validates :visit_type, presence: true
  validates :priority_level, presence: true, if: :emergency?
  validates :appointment_id, presence: true, unless: :emergency?

  after_save :set_date

  WHITELISTED_ATTRIBUTES = [
    :visit_type,
    :priority_level,
    :medical_record_id,
    :doctor_id,
    :appointment_id,
    :appointment_status
  ].freeze

  private

  def emergency?
    visit_type == 'emergency'
  end

  def set_date
    self.date = Time.zone.now
  end
end
