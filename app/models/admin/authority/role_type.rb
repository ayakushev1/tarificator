# == Schema Information
#
# Table name: admin_authority_role_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Admin::Authority::RoleType < ActiveRecord::Base
  has_many :roles, :class_name =>'Admin::Authority::Role'#, :foreign_key => 'precision_type_id'

end
