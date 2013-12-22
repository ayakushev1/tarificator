module LayoutDescriptions
  extend ActiveSupport::Concern

  module LayoutList
    LayoutElement = Struct.new(:tag, :order, :parent_name, :name, :attr)
    Layout = Struct.new(:name, :layout_elements) do
      def elements_with_parent_name(parent_name)
        self[:layout_elements].select {|x| x[:parent_name] == parent_name}
      end      

      def element_by_name(element_name)
        self[:layout_elements].find {|x| x if x[:name] == element_name}
      end      
    end
    
    def find_layout_by_name(layout_name)
      LAYOUTS.find{|x| x if x[:name] == layout_name}
    end
    
    LAYOUTS = [
      Layout.new(:main_application_layout,
        [LayoutElement.new(:div, 0,  nil, :container, {:class => "container-fluid"}),
           LayoutElement.new(:div, 0,    :container, :first_row, {:class => "row-fluid", :style => "min-height: 20px;"}),
           LayoutElement.new(:div, 1,    :container, :second_row, {:class => "row-fluid"}),
             LayoutElement.new(:div, 0, :second_row, :second_row_left_block, {:class => "span9"}),
               LayoutElement.new(:h1,  0, :second_row_left_block, :second_row_left_block_heading, {:class => "brand"}),
             LayoutElement.new(:div, 1, :second_row, :second_row_right_block, {:class => "span3"}),  
           LayoutElement.new(:div, 2,    :container, :third_row, {:class => "row-fluid"}),
             LayoutElement.new(:div, 0, :third_row, :third_row_left_column, {:class => "span2"}),
             LayoutElement.new(:div, 1, :third_row, :third_row_main_block, {:class => "span10"}),
               LayoutElement.new(:div, 0, :third_row_main_block, :main_block_top_row, {:class => "row-fluid"}),
               LayoutElement.new(:div, 1, :third_row_main_block, :main_block_top_2_row, {:class => "row-fluid"}),
               LayoutElement.new(:div, 2, :third_row_main_block, :main_block_top_3_row, {:class => "row-fluid"}),
               LayoutElement.new(:div, 3, :third_row_main_block, :main_block_top_4_row, {:class => "row-fluid"}),
        ]
        ),

      Layout.new(:horizontal_form_layout,
        [LayoutElement.new(:form, 0, nil, :form, {:class => "form-horizontal"}),
           LayoutElement.new(:legend, 0, :form, :form_legend, {}),
           LayoutElement.new(:div, 1, :form, :control_group, {:class => "control-group"}),
             LayoutElement.new(:label, 0, :control_group, :label, {:class => "control-label"}),
             LayoutElement.new(:div, 1, :control_group, :control, {:class => "controls"}),
             LayoutElement.new(nil, 1, :control_group, :button, {:class => "btn"}),
        ]
        ),

      Layout.new(:inline_form_layout,
        [LayoutElement.new(:form, 0, nil, :form, {:class => "form-inline"}),
           LayoutElement.new(:legend, 0, :form, :form_legend, {}),
           LayoutElement.new(:div, 1, :form, :control_group, {:class => "control-group"}),
             LayoutElement.new(:label, 0, :control_group, :label, {:class => "control-label"}),
             LayoutElement.new(:div, 1, :control_group, :control, {:class => "controls", :style => "width: auto"}),
             LayoutElement.new(nil, 1, :control_group, :button, {:class => "btn"}),
        ]
        ),

      Layout.new(:main_tab_layout,
        [LayoutElement.new(:div, 0, nil, :tabs, {:class => "tabbable"}),
           LayoutElement.new(:ul, 0, :tabs, :nav, {:class => "nav nav-tabs"}),
             LayoutElement.new(:li, 0, :nav, :nav_item, {}),
               LayoutElement.new(:a, 0, :nav_item, :nav_item_details, {"data-toggle" => "tab"}),
           LayoutElement.new(:div, 1, :tabs, :content, {:class => "tab-content"}),
             LayoutElement.new(:div, 0, :content, :content_item, {:class => "tab-pane"}),
        ]
        ),

      Layout.new(:main_accordion_layout,
        [LayoutElement.new(:div, 0, nil, :accordions, {:class => "accordion"}),
           LayoutElement.new(:div, 0, :accordions, :accordion_group, {:class => "accordion-group"}),
             LayoutElement.new(:div, 0, :accordion_group, :accordion_heading, {:class => "accordion-heading"}),
               LayoutElement.new(:a, 0, :accordion_heading, :accordion_heading_details, {:class => "accordion-toggle", "data-toggle" => "collapse"}),
             LayoutElement.new(:div, 1, :accordion_group, :accordion_body, {:class => "accordion-body collapse"}),
               LayoutElement.new(:div, 0, :accordion_body, :accordion_body_inner, {:class => "accordion-inner"}),
        ]
        ),

      Layout.new(:main_menu_layout,
        [LayoutElement.new(:div, 0, nil, :menu, {:class => "navbar dropdown pull-left"}),
           LayoutElement.new(:div, 0, :menu, :menu_item_group, {:class => "navbar-inner"}),
             LayoutElement.new(:a, 0, :menu_item_group, :menu_caption, {:class => "brand", "data-toggle" => "dropdown"}),
               LayoutElement.new(:span, 0, :menu_caption, :menu_carot, {:class => "caret"}),
             LayoutElement.new(:ul, 1, :menu_item_group, :menu_value, {:class => "dropdown-menu", :role => ""}),
               LayoutElement.new(:li, 1, :menu_value, :menu_item, {:class => "dropdown-submenu"}),
                 LayoutElement.new(:li, 0, :menu_value, :menu_sub_menu, {}),
               LayoutElement.new(:li, 0, :menu_value, :menu_sub_menu, {}),
        ]
        ),
    ]
  
  end
end  