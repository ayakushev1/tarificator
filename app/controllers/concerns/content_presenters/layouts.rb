module ContentPresenters
  module Layouts
    include LayoutDescriptions::LayoutList
    include ContentDescriptions::ContentList
    
    def content_with_layout(content_or_content_name, layout_name, &app_block)
      view = controller.view_context
      layout = find_layout_by_name(layout_name)
      content = content_or_content_name    
      content = find_content_by_name(content_or_content_name) unless content_or_content_name.is_a? Struct
      
      result = first_level_layout_elements(view, content, layout, app_block)
    end
    
    def first_level_layout_elements(view, content, layout, app_block)
      first_level_layout_elements = layout.elements_with_parent_name(nil).sort_by!{|element| element[:order] }
      
      first_level_layout_elements.collect do |layout_element| 
        children_layout_elements(view, layout, layout_element, content, app_block) 
      end.join.html_safe
    end
    
    def children_layout_elements(view, layout, parent_element, content, app_block, &block2)
      child_elements = layout.elements_with_parent_name(parent_element[:name]).sort_by!{|child_element| child_element[:order] }
      value = child_elements.collect {|child_element| children_layout_elements(view, layout, child_element, content, app_block){yield if block2} }.join.html_safe unless child_elements.length == 0      
      result =layout_element_view(view, layout, parent_element, content, value, app_block){yield if block2}
    end
  
    def layout_element_view(view, layout, layout_element, content, value, app_block, &block2)
      content_tag(layout_element[:tag], layout_element[:attr]) do
        (value || "".html_safe ) +
        content_value(content, layout_element[:name], app_block) + 
        yield if block2
      end
    end
  
    def content_value(content, layout_element_name, app_block)
      content.find_all_content_elements_with_layout_name(layout_element_name)
             .sort_by!{|x| x[:order]}
             .collect { |content_element| (eval(content_element[:value]) if (content_element) ) }.join.html_safe
    end
    
  
  end
end