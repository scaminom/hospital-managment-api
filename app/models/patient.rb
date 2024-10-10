class Patient < ApplicationRecord
  has_one :anamnesis, through: :medical_record
  has_one :medical_record, dependent: :destroy
  has_many :visits, dependent: :destroy, through: :medical_record

  VALID_BLOOD_TYPES = %w[A+ A- B+ B- AB+ AB- O+ O-].freeze
  VALID_GENDERS = %w[M F].freeze

  validates :insurance_number, presence: true,
                               format:   { with: /\A\d{3}-[A-Z]{3}\z/ }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :date_of_birth, presence: true
  validates :gender, presence: true, inclusion: { in: VALID_GENDERS }
  validates :address, presence: true
  validates :phone_number, presence: true,
                           format:   { with: /\A\d{10}\z/ }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :blood_type, presence:  true,
                         inclusion: { in: VALID_BLOOD_TYPES }
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
    :allergies,
    :birth_place
  ].freeze

  def age
    return nil if date_of_birth.nil?

    now = Date.current
    years = now.year - date_of_birth.year

    years -= 1 if now.month < date_of_birth.month || (now.month == date_of_birth.month && now.day < date_of_birth.day)

    years
  end

  private

  def must_be_18_or_older
    errors.add(:date_of_birth) if date_of_birth.present? && date_of_birth > 18.years.ago.to_date
  end

  def normalize_attributes
    self.first_name = first_name.strip.titleize if first_name.present?
    self.last_name = last_name.strip.titleize if last_name.present?
  end
end
