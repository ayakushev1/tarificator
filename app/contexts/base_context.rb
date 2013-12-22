class BaseContext
  extend ActiveSupport::Concern
  include Context
  include Filtrs
  include ContentPresenters::Presenter
  include ContentDescriptions::ContentList

  attr_reader :c, :v, :params, :filtrs

  def initialize user, controller
    @c = controller
    @v = c.view_context
    @params = @c.params
    @filtrs = {}

    extend Helper
    extend Presenter
  end
  
  def standart_respond_to(method)
    c.respond_to do |format|          
      format.js {c.render :inline => to_js(method), :layout => "layouts/application"}
      
      format.html {c.render :inline => to_html(method), :layout => "layouts/application"}
    end
  end  
  
  def getBinding
    return binding
  end  
  
  module Helper
    def set_current_tabs_pages(tabs_name)
      v.session[:current_tabs_page] = {} unless v.session[:current_tabs_page]
      v.session[:current_tabs_page][tabs_name] = "" unless v.session[:current_tabs_page][tabs_name]        
      v.session[:current_tabs_page][tabs_name] = v.params[:current_tabs_page][tabs_name] if v.params[:current_tabs_page] and v.params[:current_tabs_page][tabs_name] 
    end
      
    def set_current_accordion_pages(accordion_name)
      v.session[:current_accordion_page] = {} unless v.session[:current_accordion_page]
      v.session[:current_accordion_page][accordion_name] = "" unless v.session[:current_accordion_page][accordion_name]     
      v.session[:current_accordion_page][accordion_name] = v.params[:current_accordion_page][accordion_name] if v.params[:current_accordion_page] and v.params[:current_accordion_page][accordion_name]         
    end
          
  end  
  
  module Presenter
    def c_tag(*args, &block)
      v.content_tag(*args, &block)
    end

    def to_js(method)
      js_string = "\"#{c.view_context.escape_javascript self.send(method)}\""
      js_string = "$('##{c.controller_name}_#{c.action_name}').html( #{js_string});"      
    end

    def to_html(method)
      id = c.controller_name + "_" + c.action_name# + "_"
      c_tag(:div, self.send(method), {:id => id})  
    end
    
    def notice_message
      a=""
      c_tag(:p, v.flash[:notice], {:id => "notice"} ) if v.flash[:notice]
    end  
    
  end
end