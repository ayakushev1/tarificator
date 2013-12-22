class UserRoles < ActiveRecord::Migration
  def change
    create_table :admin_authority_roles do |t|
      t.string :name
      t.text :description
      t.references :role_type, index: true
 
      t.timestamps
    end    
  end
end
