class Authority::SettingAuthority
  extend ActiveSupport::Concern
  include Context
  include Filtrs

  SUPER_ADMIN = 0
  ADMIN = 1
  CONTENT_OWNER = 2

  class AuthorityInitializeException < Exception; end
  class AuthorityAuthorizingException < Exception; end

  attr_reader :searcher, :activity, :listener, :request, :filtrs

  def initialize user, activity, activity_params, controller
    extend Presenter
    extend AuthorityAction
    @searcher = user.extend Searcher
    @activity = activity.extend ActivityParticipationCreator
    @request = activity_params
    @filtrs = {}
    

    @c = controller
    @user = user
    raise AuthorityInitializeException, "Wrong user #{@user}" unless @user and @user.instance_of?(User)
    @user_authority = Admin::Authority::UserAuthority.find_or_create(@user.id)
    raise AuthorityInitializeException , "User authority was not created for #{@user}" unless @user_authority
      
  end
  
  def listing_user_authority
    in_context do
      @filtrs["user_authority"] = Filtrs::Filtr.new(@listener, "user_authority")
    end
  end
  
  module Searcher
    include ContextAccessor

  end
  
  module ActivityParticipationCreator
    include ContextAccessor

  end    
  
  module AuthorityAction
    def cancell_authorize_authority(user_to_give_authority, cancelled_authorize_role)
      if @user_authority.check_if_authorize_roles_include(cancelled_authorize_role)
        new_user_authority = Admin::Authority::UserAuthority.find_or_create(user_to_give_authority.id)
        new_user_authority.cancell_authorize_role(cancelled_authorize_role)
      else
        @c.flash[:notice] = "#{@user.name} has no right to cancell #{Admin::Authority::Role.find(new_authorize_role).name} rights"
      end
    end
    
    def give_authorize_authority(user_to_give_authority, new_authorize_role)
      if @user_authority.check_if_authorize_roles_include(new_authorize_role)
        new_user_authority = Admin::Authority::UserAuthority.find_or_create(user_to_give_authority.id)
        new_user_authority.add_authorize_role(new_authorize_role)
      else
        @c.flash[:notice] = "#{@user.name} has no right to give #{Admin::Authority::Role.find(new_authorize_role).name} rights"
      end
    end
    
  end  

  module Presenter
    def list_user_authority(view)
      view.content_tag(:div, @user_authority.authorize_roles) +
      view.content_tag(:div, SUPER_ADMIN) +
      view.content_tag(:div, @user_authority.check_if_authorize_roles_include(SUPER_ADMIN))
    end
  
    def notice_message(view)
      a=""
      view.content_tag(:p, view.flash[:notice], {:id => "notice"} ) if view.flash[:notice]
    end  

  end
end