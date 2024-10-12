class Prescription < ApplicationRecord
  belongs_to :visit

  validates :medication, presence: true
  validates :dosage, presence: true
  validates :duration, presence: true

  WHITELISTED_ATTRIBUTES = %i[
    medication
    dosage
    duration
    visit_id
  ].freeze
end
