# This migration adds an index to the user's email column
# It improves email search optimization
class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true
  end
end
