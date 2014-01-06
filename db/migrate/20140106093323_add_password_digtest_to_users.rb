class AddPasswordDigtestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string #This code uses the add_column method to add a password_digest column to the users table.
  end 
end
