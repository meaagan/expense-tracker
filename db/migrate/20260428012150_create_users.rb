class CreateUsers < ActiveRecord::Migration[8.0]
  def up
     unless ActiveRecord::Base.connection.table_exists? :users
      create_table :users do |t|
        t.string :email_address, null: false
        t.string :password_digest, null: false

        t.timestamps
      end
      add_index :users, :email_address, unique: true
     end
  end

  def down 
    if ActiveRecord::Base.connection.table_exists? :users
      drop_table(:users)
    end
end
