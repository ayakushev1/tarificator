module FiltrPresenters

  module Fields
    include LayoutDescriptions::LayoutList
    include PresenterHelper
   
    def filtr_select_field (field_desc, layout)
      if @filtr[field_desc[:field]]
        sf = p.filtr_select_field_desc(field_desc[:field])
        
        standard_caption_field(field_desc, layout, sf) + 
        standard_value_field(field_desc, layout) do
          v.collection_select(@filtr_names[:filtr_name], #filtr_name
                              sf[:filtr_field], #field_name
                              @filtr[field_desc[:field]], #model for select fields
                              sf[:look_up_id_field],   #id_field
                              sf[:look_up_name_field], #name_field                              
                              {:include_blank => 'Choose', 
                               :selected => v.session[:filtr][@filtr_names[:filtr_name]][field_desc[:field]] 
                               },
                               standard_field_parameters(field_desc, layout, sf)
                              ) 
        end
      else
        ""
      end  
    end
    
    def text_field (field_desc, layout)
      standard_caption_field(field_desc, layout) +
      standard_value_field(field_desc, layout) do
        v.text_field(@filtr_names[:filtr_name], field_desc[:field], standard_field_parameters(field_desc, layout) )
      end
    end
        
    def tag_field (field_desc, layout)
      raw = @model if @model
      standard_caption_field(field_desc, layout) +
      standard_value_field(field_desc, layout) do
        c_tag(:a, eval( field_desc[:field_name_formula].to_s.html_safe ), standard_field_parameters(field_desc, layout) )
      end
    end
    
    def model_field (field_desc, layout)
      raw =@model
      options = merge_hashes(standard_field_parameters(field_desc, layout), field_desc[:field_attributes])

      standard_caption_field(field_desc, layout) +
      standard_value_field(field_desc, layout) do
        eval( field_desc[:field_name_formula].to_s.html_safe )
      end
    end
    
    def standard_value_field(field_desc, layout, select_field_desc = nil)
      c_tag(layout.element_by_name(:control)[:tag], layout.element_by_name(:control)[:attr] ) {yield}
    end
    
    def standard_caption_field(field_desc, layout, select_field_desc = nil)
      if select_field_desc
        caption_name = select_field_desc[:filtr_caption]
        caption_attr = select_field_desc[:filtr_caption_attributes]
      else
        caption_name = field_desc[:field_caption]
        caption_attr = {}
      end
      c_tag(layout.element_by_name(:label)[:tag],
            caption_name, 
            merge_hashes(standard_caption_attr(field_desc),
                         caption_attr,
                         layout.element_by_name(:label)[:attr]
                         ) )      
    end
    
    def standard_field_parameters(field_desc, layout, select_field_desc = nil)
      if select_field_desc
        field_desc_attr = {:action_name => eval(select_field_desc[:action_url_after_update])}.merge( select_field_desc[:filtr_field_attributes] ) 
      else
        field_desc_attr = field_desc[:field_attributes] 
      end
      value = standard_field_value(field_desc)      
      standard_param = {:id => @filtr_names[:filtr_name].to_s + "_" + field_desc[:field].to_s, 
                       :filtr_name => @filtr_names[:filtr_name], 
                       :name => "#{@filtr_names[:filtr_name]}[#{field_desc[:field]}]", 
                       :field_name => field_desc[:field], 
                       :value => value,
                       :action_name => eval(p[:action_url_after_submit][:action_after_field_update]),
                       }
      merge_hashes(standard_field_params_for_special_type(field_desc, value, layout), standard_param, field_desc_attr )
    end
    
    def standard_caption_attr(field_desc)
      merge_hashes(field_desc[:caption_attributes], 
                  {:for => @filtr_names[:filtr_name].to_s + "_" + field_desc[:field].to_s,
                   })
    end
    
    def standard_field_value(field_desc)
      if v.session[:filtr][@filtr_names[:filtr_name]][field_desc[:field]]
        result = v.session[:filtr][@filtr_names[:filtr_name]][field_desc[:field]]
      else
        result = field_desc[:field_attributes][:default] if field_desc[:field_attributes][:default]
        result = eval(field_desc[:field_attributes][:default_formula]) if field_desc[:field_attributes][:default_formula]
      end
      result
    end
    
    def standard_field_params_for_special_type(field_desc, value, layout)
      if field_desc[:field_name_formula] =~ /check_box/
        checked = "checked" unless value.nil? or value == 0 or value == false or value == 'false'
        result = {:checked_value => true,
         :unchecked_value => false,
         :checked => checked}
      else
         result = {}        
      end      

      
      result = layout.element_by_name(:button)[:attr] if field_desc[:field_name_formula] =~ /submit/
      result
    end
    
  end
  

end