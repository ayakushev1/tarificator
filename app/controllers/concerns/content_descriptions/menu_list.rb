module ContentDescriptions
  module MenuList
    extend ActiveSupport::Concern
  
    MenuShowType = Array
    MenuList = Struct.new(:menu, :menu_caption, :menu_show_type, :menu_items)
    MenuItem = Struct.new(:name, :caption, :link_to, :menu_items)
    
    def find_menu_by_name(menu_name)
      MENU_LIST.find{|menu| menu if menu[:menu] == menu_name}
    end
    
    MENU_LIST = [
      MenuList.new(
        "main_admin_menu", "Main admin menu", ["show_when_user_has_authority"],
        [MenuItem.new('Users', 'Users', 'v.users_path', nil),
         ]
      ),

      MenuList.new(
        "admin_authority_menu", "Authority menu", ["show_everytime"],
        [MenuItem.new('setting_user_authorities', '', nil, 
           MenuList.new("searching_user_authority", "Searching user authority", ["show_everytime"], 
            [MenuItem.new('search_user_authorities', 'Search user authorities', "v.admin_authority_search_user_authorities_path", nil),
             MenuItem.new('url_access_authorities', 'Url access authorities', "v.admin_authority_url_access_authorities_path", nil), 
            ]) 
         )
        ]
      ),

    ]
    
  end
end