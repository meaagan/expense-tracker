class BudgetCategory < ApplicationRecord
  belongs_to :budget

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  delegate :user, to: :budget
end
