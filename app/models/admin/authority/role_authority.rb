# == Schema Information
#
# Table name: admin_authority_role_authorities
#
#  id                          :integer          not null, primary key
#  role_id                     :integer
#  name                        :string(255)
#  description                 :text
#  allowed_to_give_authorities :string(255)
#  action                      :string(255)
#  condition                   :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class Admin::Authority::RoleAuthority < ActiveRecord::Base
  include ArrayAndString

  belongs_to :role, :class_name =>'Admin::Authority::Role'

  def self.all_actions_of_roles(roles)
    actions = []
    self.where(:role_id => roles).each do |role_authority|
      actions += role_authority.string_to_array(role_authority.action)
    end
    actions.uniq
  end

  def self.all_allowed_to_give_authorities_by_roles(roles)
    allowed_to_give_authorities = []
    self.where(:role_id => roles).each do |role_authority|
      allowed_to_give_authorities += role_authority.string_to_array(role_authority.allowed_to_give_authorities)
    end
    allowed_to_give_authorities.uniq
  end

end
