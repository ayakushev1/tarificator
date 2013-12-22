class Authority::BaseAuthorities < BaseContext
  
  class AuthorityInitializeException < Exception; end
  
  attr_reader :user, :user_authorities, :user_authority, :user_roles, :controller_access_authority, :url_access_authority

  def initialize user, controller
    super
    @user = user
    raise AuthorityInitializeException, "Wrong user #{user}" unless user and user.instance_of?(User)
    user.extend UserHelper
    
    @user_authorities = Admin::Authority::UserAuthority
    @user_authorities.extend UserAuthorities

    @user_authority = user_authorities.find_or_create_user_authority(user.id)
    raise AuthorityInitializeException , "User authority was not created for #{user}" unless user_authority
    
    @user_roles = user_authority.all_roles_as_array
      
    @url_access_authority = Admin::Authority::UrlAccessAuthority
    @controller_access_authority = Admin::Authority::UrlAccessAuthority.controller_access_authority(c.controller_name, c.action_name)
    check = ((@controller_access_authority.count == 0) and !(c.controller_name == 'url_access_authorities' and c.action_name == 'init_url_access_authorities'))
#    raise AuthorityInitializeException , "Update url_access_authorities for #{c.controller_name} / #{c.action_name}" if check
      
    extend Presenter
  end
  
  module UserHelper
    include ContextAccessor

  end
  
  module UserAuthorities
    include ContextAccessor
    
  end    
  
  module Presenter
 
  end
end