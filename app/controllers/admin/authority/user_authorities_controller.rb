class Admin::Authority::UserAuthoritiesController < ApplicationController

  extend ActiveSupport::Concern
   
  def search_user_authorities
    ::Authority::SearchingUserAuthorities.new(current_user, self).search_user_authorities
  end
  
  def set_user_authority
    ::Authority::SearchingUserAuthorities.new(current_user, self).set_user_authority
  end

  def update_user_authority
    ::Authority::SearchingUserAuthorities.new(current_user, self).update_user_authority
  end
end
