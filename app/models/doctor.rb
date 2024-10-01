class Doctor < ApplicationRecord
  belongs_to :user
  belongs_to :department

  accepts_nested_attributes_for :user, update_only: true

  validates :speciality, presence: true
  validates :license_number, presence: true, uniqueness: true

  WHITELISTED_ATTRIBUTES = [
    :speciality,
    :license_number,
    :department_id,
    {
      user_attributes: User::WHITELISTED_ATTRIBUTES_REGISTRATION
    }
  ].freeze
end
