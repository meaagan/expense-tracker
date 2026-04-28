class CreateExpenses < ActiveRecord::Migration[8.0]
  def up
    unless ActiveRecord::Base.connection.table_exists? :expenses
      create_table :expenses do |t|
        t.string :name
        t.float :amount
        t.references :users, foreign_key: true

        t.timestamps
      end
    end
  end
  def down
    if ActiveRecord::Base.connection.table_exists? :expenses
      drop_table(:expenses)
    end
  end
end
