class AdminUserAction < ActiveRecord::Migration
  def change
    create_table :admin_authority_actions do |t|
      t.references :role_type, index: true
      t.string :name
      t.text :description
 
      t.timestamps
    end  
  end
end
