# == Schema Information
#
# Table name: admin_authority_roles
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  role_type_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Admin::Authority::Role < ActiveRecord::Base
  belongs_to :role_type, :class_name =>'Admin::Authority::RoleType'
  has_many :authorities, :class_name =>'Admin::Authority::RoleAuthority'

end
