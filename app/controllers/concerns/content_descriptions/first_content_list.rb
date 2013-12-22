module ContentDescriptions
  module FirstContentList
    include ContentListStruct

    CONTENTS = 
      [
      Content.new(:main_application_content, :content_with_layout, 
        [  
         ContentElement.new(:second_row_left_block_heading, 0, "'Sport site - find your partner'", nil),  
         ContentElement.new(:second_row_right_block, 0, "render :partial => 'users/user_status'", nil), 
         ContentElement.new(:main_block_top_row, 0, "Menus::Menu.new(self, 'admin_authority_menu').show", nil), 
         ContentElement.new(:main_block_top_row, 1, "Menus::Menu.new(self, 'main_admin_menu').show", nil), 
         ContentElement.new(:main_block_top_2_row, 0, "content_tag(:h3, flash[:alert])", nil),
         ContentElement.new(:main_block_top_3_row, 0, "content_tag(:h3, ('cookies size are : ' + cookies.sum.join('').length.to_s if (cookies.sum.join('').length > 3500 ) ) )", nil), 
         ContentElement.new(:main_block_top_4_row, 0, "app_block.call", nil),
        ]
        ),
        
    ]
    
  end
end  