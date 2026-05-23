class CreateBudgetsAndBudgetCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :budgets do |t|
      t.string :title, null: false
      t.float :income_per_month, null: false, default: 0.0
      t.date :period_start, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :budget_categories do |t|
      t.references :budget, null: false, foreign_key: true
      t.string :name, null: false
      t.float :amount, null: false, default: 0.0

      t.timestamps
    end
  end
end
