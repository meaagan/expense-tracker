class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :category
      t.string :name
      t.float :amount
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
