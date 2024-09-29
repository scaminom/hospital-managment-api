class Patient < ApplicationRecord
  VALID_BLOOD_TYPES = %w[A+ A- B+ B- AB+ AB- O+ O-].freeze
  VALID_GENDERS = %w[M F].freeze

  validates :insurance_number, presence: true,
                               format:   { with: /\A\d{3}-[A-Z]{3}\z/, message: 'must be in the format 123-ABC' }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :date_of_birth, presence: true
  validates :gender, presence: true, inclusion: { in: VALID_GENDERS, message: '%<value>s is not a valid gender' }
  validates :address, presence: true
  validates :phone_number, presence: true,
                           format:   { with: /\A\d{10}\z/, message: 'must be 10 digits' }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
  validates :blood_type, presence:  true,
                         inclusion: { in: VALID_BLOOD_TYPES, message: '%<value>s is not a valid blood type' }
  validate :must_be_18_or_older

  before_save :normalize_attributes

  WHITELISTED_ATTRIBUTES = [
    :insurance_number,
    :first_name,
    :last_name,
    :date_of_birth,
    :gender,
    :address,
    :phone_number,
    :email,
    :blood_type,
    :allergies
  ].freeze

  private

  def must_be_18_or_older
    if date_of_birth.present? && date_of_birth > 18.years.ago.to_date
      errors.add(:date_of_birth, 'patient must be 18 years old or older')
    end
  end

  def normalize_attributes
    self.first_name = first_name.strip.titleize if first_name.present?
    self.last_name = last_name.strip.titleize if last_name.present?
  end
end
