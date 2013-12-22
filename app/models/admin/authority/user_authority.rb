# == Schema Information
#
# Table name: admin_authority_user_authorities
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  authorize_roles  :string(255)
#  own_crud_roles   :string(255)
#  other_crud_roles :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Admin::Authority::UserAuthority < ActiveRecord::Base
  include ArrayAndString
  belongs_to :user, :class_name =>'User'

  def add_authorize_role(new_role)
    existing_roles = string_to_array(self.authorize_roles)
    self.update_attribute(:authorize_roles, (existing_roles << new_role).to_s)  unless existing_roles.include?(new_role)      
  end  

  def cancell_authorize_role(cancelled_role)
    existing_roles = string_to_array(self.authorize_roles)
    cancelled_role_as_array = [] << cancelled_role
    self.update_attribute(:authorize_roles, (existing_roles - cancelled_role_as_array).to_s)      
  end  
  
  def self.find_or_create_user_authority(user_id)
    result = find_by_user(user_id)
    result = create_default(user_id) unless result
    result
  end

  def self.find_by_user(user_id)
    where(:user_id => user_id).first
  end
  
  def self.create_default(user_id)
    create!(:user_id => user_id, :authorize_roles => "[]", :own_crud_roles => "[]", :other_crud_roles => "[25]")
  end

  def all_roles_as_array
    string_to_array(self[:authorize_roles]) + string_to_array(self[:own_crud_roles]) + string_to_array(self[:other_crud_roles]) 
  end
  
  def include_any_role?(array)
    (self.all_roles_as_array & array).blank? ? false : true    
  end
  
  def self.all_user_roles(user_id)
    user_role = self.find_by_user(user_id)
    return [] unless user_role
    user_role.all_roles_as_array
  end
  
  def allowed_to_give_authorities
    Admin::Authority::RoleAuthority.all_allowed_to_give_authorities_by_roles(self.all_roles_as_array)
  end

  def allowed_actions
    Admin::Authority::RoleAuthority.all_actions_of_roles(self.all_roles_as_array)
  end

end
