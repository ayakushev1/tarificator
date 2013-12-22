class RoleTypes < ActiveRecord::Migration
  def change
    create_table :admin_authority_role_types do |t|
      t.string :name
 
      t.timestamps
    end    
  end
end
