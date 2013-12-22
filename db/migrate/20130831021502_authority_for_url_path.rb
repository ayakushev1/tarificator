class AuthorityForUrlPath < ActiveRecord::Migration
  def change
    create_table :admin_authority_url_access_authorities do |t|
      t.string :controller_path, index: true
      t.string :route_path, index: true
      t.string :controller, index: true
      t.string :action, index: true
      t.boolean :restricted, index: true
      t.string :access_authorized_roles
      t.string :condition
      t.string :method_to_call_before_condition
      t.boolean :processed, index: true

      t.timestamps
    end
  end
end
