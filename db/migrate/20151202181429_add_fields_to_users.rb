class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	# Personal information
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :phone, :string
    add_column :users, :birthday, :datetime
    add_column :users, :sex, :string

    # Professional information
    add_column :users, :education_level, :string
    add_column :users, :institution, :string
  end
end
