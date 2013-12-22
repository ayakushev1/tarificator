module FiltrPresenters

  module Forms
    include LayoutDescriptions::LayoutList
    include PresenterHelper
   
    def form(layout_name = :horizontal_form_layout)
      layout = find_layout_by_name(layout_name)

      form_attr = merge_hashes(
                               {:id => p[:filtr_names][:table_name]},
                                layout.element_by_name(:form)[:attr],
                                p[:action_url_after_submit][:form_attr],
                                p[:filtr_main_attr][:main_filtr_attr])
      form_action= eval(p[:action_url_after_submit][:action])


      flash_alert +
      form_legend(layout) +
      v.form_tag( form_action, form_attr ) do
        p[:fields_desc].sort_by!{|field_desc| field_desc[:order]}
                       .collect { |field_desc| form_field_group(field_desc, layout) }.join("").html_safe
      end
    end
    
    def form_legend(layout)
      if p[:filtr_main_attr][:filtr_caption].blank? 
        "".html_safe
      else 
        c_tag(layout.element_by_name(:form_legend)[:tag], 
              p[:filtr_main_attr][:filtr_caption].html_safe,
              layout.element_by_name(:form_legend)[:attr] )
      end 
    end
    
    def form_field_group(field_desc, layout)
      layout_form_attr = merge_hashes(layout.element_by_name(:control_group)[:attr], add_hide_class_if_fields_and_caption_hidden(field_desc))
      c_tag(layout.element_by_name(:control_group)[:tag], layout_form_attr) do
        Fields.method_defined?(field_desc[:field_type]) ? 
                              self.send(field_desc[:field_type], field_desc, layout) : 
                              self.send(:text_field, field_desc, layout)
      end 
    end
    
    def add_hide_class_if_fields_and_caption_hidden(field_desc)
      if (field_desc[:field_attributes][:class] =~ /\bhide\b/ ) and (field_desc[:caption_attributes][:class] =~ /\bhide\b/ )
        {:class => 'hide'}
      else
        {}
      end
      
    end
      
  end
  

end