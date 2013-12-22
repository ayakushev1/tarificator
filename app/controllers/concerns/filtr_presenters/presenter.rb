module FiltrPresenters
  
  module Presenter
    include FiltrPresenters::JsonEventsToFullcalendar
    include FiltrPresenters::Forms
    include FiltrPresenters::Fields
    include FiltrPresenters::Tables
    
    def flash_alert
      (c_tag(:p, v.flash[:alert], {:id => "notice"} ) if v.flash[:alert]) || "".html_safe
    end
    
    def show(layout_name = nil)
      filtr_type = p[:filtr_main_attr][:filtr_query_type]
            
      layout_name ? self.send(filtr_type, layout_name) : self.send(filtr_type)
    end
    
  end

end