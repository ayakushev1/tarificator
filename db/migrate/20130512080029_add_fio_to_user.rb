class AddFioToUser < ActiveRecord::Migration
  def change
    add_column :users, :surname, :string
    add_column :users, :firstname, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :main_location_id, :integer
  end
end
