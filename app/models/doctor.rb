class Doctor < ApplicationRecord
  belongs_to :user
  belongs_to :department
  has_many :visits, dependent: :destroy

  accepts_nested_attributes_for :user, update_only: true

  validates :speciality, presence: true
  validates :license_number, presence: true, uniqueness: true,
                             format: { with: /\A[A-Z]{2}\d{6}\z/, message: 'must be in the format AA123456' }

  WHITELISTED_ATTRIBUTES = [
    :speciality,
    :license_number,
    :department_id,
    {
      user_attributes: User::WHITELISTED_ATTRIBUTES_REGISTRATION
    }
  ].freeze
end
