class Department < ApplicationRecord
  has_many :doctors, dependent: :nullify

  validates :name, presence: true
  validates :floor, presence: true, numericality: { only_integer: true, greater_than: 0 }

  WHITELISTED_ATTRIBUTES = [:name, :floor].freeze
end
