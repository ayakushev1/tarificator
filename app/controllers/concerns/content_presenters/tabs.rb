module ContentPresenters

  module Tabs
    include LayoutDescriptions::LayoutList
    include ContentDescriptions::ContentList
   
    def tabs(layout_name = :main_tab_layout)
      layout = find_layout_by_name(layout_name)
      
      c_tag(layout.element_by_name(:tabs)[:tag], merge_hashes(layout.element_by_name(:tabs)[:attr], 
                                                              content.element_by_layout_name(:tabs)[:value_attr],
                                                              {:active => active_element, :name => name.to_s}
                                                               ) ) do
        c_tag(layout.element_by_name(:nav)[:tag], layout.element_by_name(:nav)[:attr] ) do
          i = 0
          content.find_all_content_elements_with_layout_name(:nav_item_details).sort_by!{|x| x[:order]}.collect do |content_element|
            i += 1
            c_tag(layout.element_by_name(:nav_item)[:tag], layout.element_by_name(:nav_item)[:attr] ) do
              c_tag(layout.element_by_name(:nav_item_details)[:tag], 
                    content_element[:value],
                    merge_hashes(layout.element_by_name(:nav_item_details)[:attr],
                                 content_element[:value_attr],
                                 {:href => "##{content[:name]}_#{i.to_s}"} ) )
            end
          end.join.html_safe          
        end +

        c_tag(layout.element_by_name(:content)[:tag], layout.element_by_name(:content)[:attr] ) do
          i = 0
          content.find_all_content_elements_with_layout_name(:content_item).sort_by!{|x| x[:order]}.collect do |content_element|
            i += 1
            c_tag(layout.element_by_name(:content_item)[:tag], 
                  eval(content_element[:value], context.getBinding),
                  merge_hashes(layout.element_by_name(:content_item)[:attr], 
                               content_element[:value_attr],
                               {:id => "#{content[:name]}_#{i.to_s}"} ) )
          end.join.html_safe          
        end
      end
    end
    
    
      
  end
  

end