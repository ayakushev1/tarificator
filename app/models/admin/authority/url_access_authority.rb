# == Schema Information
#
# Table name: admin_authority_url_access_authorities
#
#  id                              :integer          not null, primary key
#  controller_path                 :string(255)
#  route_path                      :string(255)
#  controller                      :string(255)
#  action                          :string(255)
#  restricted                      :boolean
#  access_authorized_roles         :string(255)
#  condition                       :string(255)
#  method_to_call_before_condition :string(255)
#  processed                       :boolean
#  created_at                      :datetime
#  updated_at                      :datetime
#

class Admin::Authority::UrlAccessAuthority < ActiveRecord::Base
  include ArrayAndString

  def self.controller_access_authority(controller_name, action_name)
    where(:controller => controller_name, :action => action_name)
  end
  
  def authorised_roles
    string_to_array(self[:access_authorized_roles])
  end

  def include_any?(roles)
    (self.authorised_roles & roles).blank? ? false : true
  end

end
