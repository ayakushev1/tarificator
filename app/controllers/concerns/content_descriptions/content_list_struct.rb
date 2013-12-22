module ContentDescriptions
  module ContentListStruct
    extend ActiveSupport::Concern

    Content = Struct.new(:name, :type, :content_elements) do
      def find_all_content_elements_with_layout_name(layout_element_name)
        self[:content_elements].select{|x| x if (x[:layout_element_name] == layout_element_name)}
      end

      def element_by_layout_name(layout_element_name)
        self[:content_elements].find {|x| x if x[:layout_element_name] == layout_element_name}
      end      
    
    end
    ContentElement = Struct.new(:layout_element_name, :order, :value, :value_attr)

  end
end  