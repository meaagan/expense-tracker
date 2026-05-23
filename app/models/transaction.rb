class Transaction < ApplicationRecord
    DEFAULT_CATEGORIES = %w[Groceries Leisure Electronics Utilities Clothing Health Others].freeze

    validates :category, presence: true
    validates :name, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :date, presence: true

    belongs_to :user

    def category_name
        category.to_s.titleize
    end

    def self.budget
        Budget.where("period_start < :date", date: date)
    end
end
