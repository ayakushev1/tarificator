module ContentPresenters

  module Accordions
    include LayoutDescriptions::LayoutList
    include ContentDescriptions::ContentList
   
    def accordions(layout_name = :main_accordion_layout)
      layout = find_layout_by_name(layout_name)
      id = "accordion_" + name.to_s
      
      c_tag(layout.element_by_name(:accordions)[:tag], merge_hashes(layout.element_by_name(:accordions)[:attr], 
                                                                    content.element_by_layout_name(:accordions)[:value_attr],
                                                                    {:id => id, :active => active_element, :name => name.to_s} 
                                                                    ) ) do
        i = -1
        content.find_all_content_elements_with_layout_name(:accordion_heading_details).sort_by!{|x| x[:order]}.collect do |content_element|
          body_content_element = content[:content_elements]
                                  .find{|x| x if x[:layout_element_name] == :accordion_body_inner and x[:order] == content_element[:order]}
          i += 1
          c_tag(layout.element_by_name(:accordion_group)[:tag], layout.element_by_name(:accordion_group)[:attr]) do
            c_tag(layout.element_by_name(:accordion_heading)[:tag], layout.element_by_name(:accordion_heading)[:attr] ) do
              c_tag(layout.element_by_name(:accordion_heading_details)[:tag], 
                    content_element[:value],
                    merge_hashes(layout.element_by_name(:accordion_heading_details)[:attr],
                                 content_element[:value_attr],
                                 {"data-parent" => "##{id}", :href => "##{id}_#{i.to_s}"} ) )
            end +
                     
            c_tag(layout.element_by_name(:accordion_body)[:tag], 
                  merge_hashes(layout.element_by_name(:accordion_body)[:attr], {:id => "#{id}_#{i.to_s}"} )
                  ) do
              c_tag(layout.element_by_name(:accordion_body_inner)[:tag], 
                    eval(body_content_element[:value], context.getBinding),
                    merge_hashes(layout.element_by_name(:accordion_body_inner)[:attr], 
                                 body_content_element[:value_attr] ) )
            end
          end
        end.join.html_safe
      end
    end
    
          
  end
  

end