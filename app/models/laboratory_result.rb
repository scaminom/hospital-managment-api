class LaboratoryResult < ApplicationRecord
  belongs_to :visit

  enum :status, {
    pending:     0,
    in_progress: 1,
    completed:   2,
    cancelled:   3
  }, validates: true

  validates :lab_type, presence: true
  validates :name, presence: true
  validates :status, presence: true, on: :update
  validate :results_can_only_be_set_when_completed

  WHITELISTED_ATTRIBUTES = %i[
    lab_type
    name
    results
    visit_id
    status
  ].freeze

  private

  def results_can_only_be_set_when_completed
    errors.add(:results, :status_creation) if results.present? && status != 'completed'
  end
end
