class Admin::Authority::UrlAccessAuthoritiesController < ApplicationController
  extend ActiveSupport::Concern
       
  def init_url_access_authorities
    ::Authority::InitilizingUrlAccessAuthorities.new(current_user, self).init_url_access_authorities
  end
  
  def set_url_access_authorities
  end
  
  def new_url_access_authority
  end

  def edit_url_access_authority
  end

  def create_url_access_authority
  end
    
  def update_url_access_authority
  end
    
  def delete_url_access_authority
  end
    
  def check_url_access_authorities
  end
  
  def context_class
    ::Authority::CheckingUrlAccessAuthorities
  end
  
end
