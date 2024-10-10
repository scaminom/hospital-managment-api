class Visit < ApplicationRecord
  belongs_to :medical_record
  belongs_to :doctor
  has_one :patient, through: :medical_record
  has_one :anamnesis, through: :medical_record
  has_many :prescriptions, dependent: :restrict_with_error
  has_many :laboratory_results, dependent: :restrict_with_error

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

  WHITELISTED_ATTRIBUTES = %i[
    visit_type
    priority_level
    medical_record_id
    doctor_id
    room
  ].freeze

  private

  def emergency?
    visit_type == 'emergency'
  end
end
