# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  password_digest  :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  surname          :string(255)
#  firstname        :string(255)
#  date_of_birth    :date
#  main_location_id :integer
#

class User < ActiveRecord::Base
  has_many :user_authorities, :class_name => 'Admin::Authority::UserAuthority', :foreign_key => 'user_id'
  
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
end

