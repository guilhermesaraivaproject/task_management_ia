class Task < ApplicationRecord
  belongs_to :user

  STATUSES = %w[pending in_progress completed].freeze

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :due_date, presence: true

  scope :pending, -> { where(status: 'pending') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }
  scope :overdue, -> { where('due_date < ?', Date.current) }

  def overdue?
    due_date < Date.current
  end
end
