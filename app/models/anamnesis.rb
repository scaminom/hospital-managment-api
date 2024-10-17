class Anamnesis < ApplicationRecord
  belongs_to :medical_record
  has_one :patient, through: :medical_record
  has_one :visit, through: :medical_record

  VALID_MARITAL_STATUSES = %w[Single Married Divorced Widowed].freeze

  validates :current_residence, presence: true
  validates :education_level, presence: true
  validates :occupation, presence: true
  validates :marital_status, presence: true, inclusion: { in: VALID_MARITAL_STATUSES }
  validates :religion, presence: true
  validates :handedness, presence: true
  validates :family_reference, presence: true
  validates :medical_history, length: { maximum: 1000 }

  WHITELISTED_ATTRIBUTES = %i[
    current_residence
    education_level
    occupation
    marital_status
    religion
    handedness
    family_reference
    gender_identity
    medical_history
    medical_record_id
  ].freeze
end
