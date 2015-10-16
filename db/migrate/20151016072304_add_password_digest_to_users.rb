# Add a password field to user model.
# Hashed password and password digest are synonyms.
class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :string
  end
end
