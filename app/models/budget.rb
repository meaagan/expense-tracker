class Budget < ApplicationRecord
  belongs_to :user
  has_many :budget_categories, dependent: :destroy

  validates :title, presence: true
  validates :income_per_month, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :period_start, presence: true

  accepts_nested_attributes_for :budget_categories, allow_destroy: true, reject_if: :all_blank

  def category_totals(transactions = user.transactions)
    transactions.where(category: budget_categories.pluck(:name)).group(:category).sum(:amount)
  end

  def category_status(transactions = user.transactions)
    totals = category_totals(transactions)

    budget_categories.map do |budget_category|
      spent = totals[budget_category.name].to_f
      {
        name: budget_category.name,
        budgeted: budget_category.amount,
        spent: spent,
        over_budget: spent > budget_category.amount
      }
    end
  end
end
