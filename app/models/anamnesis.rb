class Anamnesis < ApplicationRecord
  belongs_to :medical_record
  has_one :patient, through: :medical_record
  has_one :visit, through: :medical_record
end
