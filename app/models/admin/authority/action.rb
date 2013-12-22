# == Schema Information
#
# Table name: admin_authority_actions
#
#  id           :integer          not null, primary key
#  role_type_id :integer
#  name         :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Admin::Authority::Action < ActiveRecord::Base
  belongs_to :role_type, :class_name =>'Admin::Authority::RoleType'

end
