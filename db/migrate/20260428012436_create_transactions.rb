class CreateTransactions < ActiveRecord::Migration[8.0]
  def up
    unless ActiveRecord::Base.connection.table_exists? :transactions
      create_table :transactions do |t|
        t.string :name
        t.float :amount
        t.string :category
        t.datetime :date
        t.references :user, foreign_key: true

        t.timestamps
      end
    end
  end
  def down
    if ActiveRecord::Base.connection.table_exists? :transactions
      drop_table(:transactions)
    end
  end
end
