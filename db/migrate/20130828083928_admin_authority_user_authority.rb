class AdminAuthorityUserAuthority < ActiveRecord::Migration
  def change
    create_table :admin_authority_user_authorities do |t|
      t.references :user, index: true
      t.string :authorize_roles
      t.string :own_crud_roles
      t.string :other_crud_roles

      t.timestamps
    end   
  end
end
