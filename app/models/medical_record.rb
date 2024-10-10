class MedicalRecord < ApplicationRecord
  belongs_to :patient
  has_one :anamnesis, dependent: :destroy
  has_many :visits, dependent: :destroy

  validates :notes, length: { maximum: 1000 }

  WHITELISTED_ATTRIBUTES = [
    :patient_id,
    :notes
  ].freeze
end
