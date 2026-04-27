class Expense < ApplicationRecord
    CATEGORIES = {
        Groceries: 0,
        Leisure: 1,
        Electronics: 2,    
        Utilities: 3,
        Clothing: 4,
        Health: 5,
        Others: 6
    }.freeze
    
    belongs_to :user
    validates :category, presence: true, inclusion: { in: CATEGORIES.keys.map(&:to_s) }
    validates :name, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :date, presence: true

    def category_name
        CATEGORIES[category.to_sym]
    end
end
