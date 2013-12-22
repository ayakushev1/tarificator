class Authority::CheckingUrlAccessAuthorities < Authority::BaseAuthorities
  
  def initialize user, controller
    super 
    extend UrlAccessAuthoritySystem 
    extend Presenter    
  end

  def set_url_access_authorities
    in_context do
        @filtrs["url_access_authorities"] = Filtrs::Filtr.new(c, "url_access_authorities")         
        standart_respond_to(:setting_url_access_authorities)
    end
  end
  
  def new_url_access_authority
    in_context do
        @filtrs["url_access_authority"] = Filtrs::Filtr.new(c, "new_url_access_authority")         
        standart_respond_to(:editting_url_access_authority)
    end
  end
  
  def edit_url_access_authority
    in_context do
        @filtrs["url_access_authority"] = Filtrs::Filtr.new(c, "edit_url_access_authority")         
        standart_respond_to(:editting_url_access_authority)
    end
  end
  
  def create_url_access_authority
    in_context do
      if @url_access_authority.new().update_attributes(c.params.require(:url_access_authority_filtr).permit!)
        c.redirect_to c.admin_authority_url_access_authorities_path
      else
        c.redirect_to c.admin_authority_edit_url_access_authorities_path, :alert => "Something wrong with saving"
      end
    end
  end
  
  def update_url_access_authority
    in_context do
      if @url_access_authority.find(c.params[:url_access_authority_filtr][:id])
                                    .update_attributes(c.params.require(:url_access_authority_filtr).permit!
                                    )
        c.redirect_to c.admin_authority_url_access_authorities_path
      else
        c.redirect_to c.admin_authority_edit_url_access_authorities_path, :alert => "Something wrong with saving"
      end
    end
  end
  
  def delete_url_access_authority
    in_context do
      @url_access_authority.find(c.params[:id]).destroy
      c.redirect_to c.admin_authority_url_access_authorities_path
    end
  end
  
  def check_url_access_authorities
    in_context do
      c.redirect_to :root, :alert => "You do not have access to #{c.controller_name}##{c.action_name} " unless check_if_user_have_access_to_url
    end
  end
  
  module UrlAccessAuthoritySystem
    
    def check_if_user_have_access_to_url
      checked_url = @url_access_authority.controller_access_authority(c.controller_name, c.action_name).first
      if checked_url
        checked_url.include_any?(user_roles)
      else
        false
      end
    end
    
  end    

  module Presenter
    def setting_url_access_authorities
      c_tag(:h3, notice_message) + 
      c_tag(:p, v.link_to('Init url_access_authorities', v.admin_authority_init_url_access_authorities_path, {:confirm => 'Are you sure?'} ) ) + 
      c_tag(:div, @filtrs["url_access_authorities"].show)  
    end

    def editting_url_access_authority
      c_tag(:h3, notice_message) + 
      c_tag(:div, @filtrs["url_access_authority"].show)  
    end
  end
  
end