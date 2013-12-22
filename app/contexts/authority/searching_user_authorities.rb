class Authority::SearchingUserAuthorities < Authority::BaseAuthorities

  def initialize use, controller
    super 
    user_authorities.extend UserAuthorities
    extend Presenter    
  end

  def search_user_authorities
    in_context do
        @filtrs["user_authorities"] = Filtrs::Filtr.new(c, "user_authorities")
        @filtrs["all_roles"] = Filtrs::Filtr.new(c, "all_roles")
        @filtrs["authorize_roles"] = Filtrs::Filtr.new(c, "authorize_roles")
        @filtrs["own_crud_roles"] = Filtrs::Filtr.new(c, "own_crud_roles")
        @filtrs["other_crud_roles"] = Filtrs::Filtr.new(c, "other_crud_roles")
        
        standart_respond_to(:searching_user_authorities)
    end
  end
  
  module UserAuthorities
    
  end    
  
  module Presenter
    def searching_user_authorities
        c_tag(:h3, notice_message) + 
        c_tag(:div, @filtrs["user_authorities"].show) +  
        c_tag(:div, @filtrs["all_roles"].show)
    end
  end
end