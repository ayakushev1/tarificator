module Menus
  extend ActiveSupport::Concern

  class Menu
    include ContentDescriptions::MenuList
    
    attr_reader :menu, :v

    class MenuInitializeException < Exception; end
    
    def initialize(view, menu_name)
      @menu = find_menu_by_name(menu_name)
      @v = view
      
      raise MenuInitializeException, "Wrong menu name, #{menu_name}" unless @menu 
      
      self.extend MenuPresenter
    end

    def show?
      show = true
      @menu[:menu_show_type].each do |show_type|
        case show_type
        when "show_everytime"
          show = true
        when "show_when_user_has_authority"
          show = check_if_user_has_authority  
          break if show == false
        when "show_for_specific_cotroller_and_action"
          show = check_if_show_for_specific_controller_and_action 
          break if show == false
        else
          show = false
          break
        end
      end
    end
    
    def show
      show_menu(@menu) if show?
    end
    
    def check_if_user_has_authority
      true
    end
    
    def check_if_show_for_specific_controller_and_action
      true
    end
      
    def c_tag(*args, &block)
      v.content_tag(*args, &block)
    end
  
      
  end
  
  module MenuPresenter
    def show_menu(menu)
      c_tag(:div, {:class => "navbar dropdown pull-left"}) do
        c_tag(:div, show_menu_items(menu, true), {:class => "navbar-inner"}) 
      end
    end
    
    def show_menu_items(menu, first_level)
      caption_show_class = ("brand" if first_level) || ""
      
      c_tag(:a, {:class => caption_show_class, "data-toggle" => "dropdown"}) do
        menu[:menu_caption].html_safe +
        (c_tag(:span, nil, {:class => "caret"}) if first_level )
      end +  
      c_tag(:ul, {:class => "dropdown-menu",  :role => ""}) do
        menu[:menu_items].collect { |menu_item| show_menu_item(menu_item) }.join("").html_safe 
      end
    end
    
    def show_menu_item(menu_item)
      menu_item_view = ""
      if menu_item[:menu_items]
        menu_item_view = c_tag(:li, show_menu_items(menu_item[:menu_items], false), {:class => "dropdown-submenu"})
      end
      
      if menu_item[:link_to]  
        menu_item_view += c_tag(:li) do
          v.link_to(menu_item[:caption], eval(menu_item[:link_to]) )
        end   
      end
      menu_item_view
    end
    
  end
    
end