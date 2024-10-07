class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, { guess: 0, admin: 1, doctor: 2, nurse: 3 }

  validates :email, uniqueness: true, allow_blank: true, on: :update
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  WHITELISTED_ATTRIBUTES = [
    :username,
    :email,
    :password,
    :role,
    :first_name,
    :last_name
  ].freeze

  WHITELISTED_ATTRIBUTES_REGISTRATION = [
    :username,
    :email,
    :password,
    :first_name,
    :last_name
  ].freeze

  def jwt_payload
    super.merge(
      'role' => role
    )
  end
end
