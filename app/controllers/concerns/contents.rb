module Contents
  extend ActiveSupport::Concern
  
  class Content
    include ContentDescriptions::ContentList
    include ContentDescriptions::ContentListStruct
    
    attr_reader :context, :content, :c, :v, :name, :active_element
    
    class ContentInitializeException < Exception; end
    
    def initialize(context, content_or_content_name)
      @context = context
      @v = context.v
      @content = content_or_content_name    
      @content = find_content_by_name(content_or_content_name) unless content_or_content_name.is_a? Struct
      raise ContentInitializeException, "Wrong content name, #{@content}" unless @content
      
      @name = content[:name]
      @active_element = nil
      
      make_initial_setup
      
      self.extend ContentPresenters::Presenter      
      self.extend Helper      
    end
    
    def make_initial_setup
      case content[:type]
      when :tabs
        set_current_tabs_pages
        @active_element = v.session[:current_tabs_page][name] 
      when :accordions
        set_current_accordion_pages
        @active_element = v.session[:current_accordion_page][name]
      end
    end
    
    def set_active_element
      
    end

    def set_current_tabs_pages
      v.session[:current_tabs_page] = {} unless v.session[:current_tabs_page]
      v.session[:current_tabs_page][name] = "" unless v.session[:current_tabs_page][name]        
      v.session[:current_tabs_page][name] = v.params[:current_tabs_page][name] if v.params[:current_tabs_page] and v.params[:current_tabs_page][name] 
    end
      
    def set_current_accordion_pages
      v.session[:current_accordion_page] = {} unless v.session[:current_accordion_page]
      v.session[:current_accordion_page][name] = "" unless v.session[:current_accordion_page][name]     
      v.session[:current_accordion_page][name] = v.params[:current_accordion_page][name] if v.params[:current_accordion_page] and v.params[:current_accordion_page][name]         
    end
          
    
   
  end
  
  module Helper
    def c_tag(*args, &block)
      context.c_tag(*args, &block)
    end
    
  end
  
  
  

end