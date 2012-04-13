class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :email
    add_index :users, :dob
    add_index :users, :score
  end
end
