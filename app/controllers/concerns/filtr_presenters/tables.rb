module FiltrPresenters
  
  module Tables
    include LayoutDescriptions::LayoutList
    include PresenterHelper
    
    def table(layout_name = :horizontal_form_layout)
      layout = find_layout_by_name(layout_name)
        
      table_legend(layout) +
      c_tag(:table, {:id => p[:filtr_names][:table_name], :class => "table table-hover table-bordered table-condensed"} ) do
        c_tag(:thead, table_head(layout), {:id => p[:filtr_names][:table_head_name] } ) +
        c_tag(:tbody, table_body(layout), {:id => p[:filtr_names][:table_body_name] } )
      end   
    end
    
    def table_legend(layout)
      if p[:filtr_main_attr][:filtr_caption].blank? 
        "".html_safe 
      else
        c_tag(layout.element_by_name(:form_legend)[:tag], 
              p[:filtr_main_attr][:filtr_caption].html_safe,
              layout.element_by_name(:form_legend)[:attr] )
      end       
    end

    def table_head(layout)
      c_tag :tr do
        table_head_paginate(layout) +
        p[:fields_desc].sort_by!{|field_desc| field_desc[:order]}
                       .collect{ |field_desc| table_head_column(field_desc, layout)}.join("").html_safe
      end
    end
    
    def table_head_paginate(layout)
      number_of_visible_fields = p[:fields_desc].count { |x| x[:field_attributes][:hidden] == false}
      
      c_tag :tr do
        c_tag :th, {:colspan => number_of_visible_fields} do
          c_tag :div do 
           v.will_paginate(@model_raws_to_show, p[:paginate_param][:paginate_attributes])
          end  
        end   
      end  
    end
    
    def table_head_column(field_desc, layout)      
      c_tag :th, field_desc[:field_attributes] do
        c_tag(:a, field_desc[:field_caption], field_desc[:caption_attributes]) +
        c_tag(:div, filtr_select_field(field_desc, layout) )
      end
    end

    def table_body(layout)
      @model_raws_to_show.collect do |raw|
        c_tag :tr, table_body_raw(raw, layout), {
                      :current_id_name => @filtr_names[:current_id_name], 
                      :name => "current_id[#{@filtr_names[:current_id_name]}]", 
                      :action_name => v.url_for(eval(p[:action_url_after_submit][:action])), 
                      :raw_name => @filtr_names[:raw_name],
                      :class => ( "current_table_raw" if raw.id.to_s == c.session[:current_id][@filtr_names[:current_id_name]].to_s ), 
                      :id => @filtr_names[:raw_name].to_s + "_" + raw.id.to_s, 
                      :value => raw.id
                      }
      end.join("").html_safe      
    end
    
    def table_body_raw(raw, layout)
      p[:fields_desc].sort_by!{|field_desc| field_desc[:order]}
                     .collect { |field_desc| table_body_column(raw, field_desc, layout)}.join("").html_safe
    end  
    
    def table_body_column(raw, field_desc, layout)    
      c_tag(:td, 
                    eval(field_desc[:field_name_formula]),
                    field_desc[:field_attributes]
                    )
    end
    
  end

end