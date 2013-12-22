class UserRoleAuthotiry < ActiveRecord::Migration
  def change
    create_table :admin_authority_role_authorities do |t|
      t.references :role, index: true
      t.string :name
      t.text :description
      t.string :allowed_to_give_authorities
      t.string :action
      t.string :condition
 
      t.timestamps
    end  
  end
end
