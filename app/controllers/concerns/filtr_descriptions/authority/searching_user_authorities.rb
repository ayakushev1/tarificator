module FiltrDescriptions
  module Authority
    module SearchingUserAuthorities
      include FiltrListStruct
  
      FILTR_PARAM = [
        FiltrParam.new(
           FiltrKey.new("admin/authority/user_authorities", "search_user_authorities", "user_authorities"),
           nil,
           FiltrActionURL.new("v.admin_authority_search_user_authorities_path", '', {:method => :get, :turbolinks => true}),
           "Admin::Authority::UserAuthority.with_all_belongs_included",         
           [],
           FiltrMainAttr.new(:table, "Searching user authorities", {}),
           [FiltrSelectField.new(:user_id, "", "User", "users", :id, :name, "v.admin_authority_search_user_authorities_path", {}, {}),
            FiltrSelectField.new(:authorize_roles, "", "Admin::Authority::UserAuthority.select(:authorize_roles).uniq", "admin_authority_user_authorities", :authorize_roles, :authorize_roles, "v.admin_authority_search_user_authorities_path", {}, {}), 
            FiltrSelectField.new(:own_crud_roles, "", "Admin::Authority::UserAuthority.select(:own_crud_roles).uniq", "admin_authority_user_authorities", :own_crud_roles, :own_crud_roles, "v.admin_authority_search_user_authorities_path", {}, {}), 
            FiltrSelectField.new(:other_crud_roles, "", "Admin::Authority::UserAuthority.select(:other_crud_roles).uniq", "admin_authority_user_authorities", :other_crud_roles, :other_crud_roles, "v.admin_authority_search_user_authorities_path", {}, {}) 
           ],
           [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'hide'}, {}),
            FieldsDesc.new(1, :user_id, :field, "User", "raw.user.name if raw.user", {:class => 'unhide'}, {}),
            FieldsDesc.new(2, :allowed_to_give_authorities, :field, "Allowed to give authorities", "raw.allowed_to_give_authorities", {:class => 'unhide'}, {}),
            FieldsDesc.new(3, :allowed_actions, :field, "Allowed actions", "raw.allowed_actions", {:class => 'unhide'}, {}),
            FieldsDesc.new(4, :authorize_roles, :field, "Authorize roles", "raw.authorize_roles", {:class => 'unhide'}, {}),
            FieldsDesc.new(5, :own_crud_roles, :field, "Own crud roles", "raw.own_crud_roles", {:class => 'unhide'}, {}),
            FieldsDesc.new(6, :other_crud_roles, :field, "Other's crud roles", "raw.other_crud_roles", {:class => 'unhide'}, {}),
            FieldsDesc.new(7, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
            FieldsDesc.new(8, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
            FieldsDesc.new(9, :edit, :link_to_id, "", "v.link_to 'Edit', v.admin_authority_set_user_authority_path(raw.id)", {:class => 'hide'}, {}),
            ],
           [:id],
           FiltrNames.new(:user_authorities_filtr, :user_authority_id, :user_authorities_raw, :user_authorities, :user_authorities_head, :user_authorities_body),
           FiltrPaginate.new(:user_authorities_page, 20, {:class =>'pagination pagination-centered', :param_name=> :user_authorities_page}),
           :check
           ),
           
        FiltrParam.new(
           FiltrKey.new("admin/authority/user_authorities", "search_user_authorities", "all_roles"),
           nil,
           FiltrActionURL.new("v.admin_authority_search_user_authorities_path", '', {:method => :get, :turbolinks => true}),
           "Admin::Authority::Role.with_all_belongs_included",         
           [InitialFiltr.new("id", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).all_roles_as_array", 
                             "Admin::Authority::UserAuthority.find_by_id(session[:current_id][:user_authority_id])"),
            InitialFiltr.new("id", "-1", "Admin::Authority::UserAuthority.find_by_id(session[:current_id][:user_authority_id]) and " + 
                             "Admin::Authority::UserAuthority.find_by_id(session[:current_id][:user_authority_id]).all_roles_as_array.blank?")
           ],
           FiltrMainAttr.new(:table, "", {}),
           [],
           [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'unhide'}, {}),
            FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
            FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'unhide'}, {}),
            FieldsDesc.new(3, :role_type_id, :field, "Role type", "raw.role_type.name if raw.role_type", {:class => 'unhide'}, {}),
            FieldsDesc.new(4, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
            FieldsDesc.new(5, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
            ],
           [:id],
           FiltrNames.new(:user_authorities_page, :all_role_id, :all_roles_raw, :all_roles, :all_roles_head, :all_roles_body),
           FiltrPaginate.new(:all_roles_page, 10, {:class =>'pagination pagination-centered', :param_name=> :all_roles_page}),
           :check
           ),
           
        FiltrParam.new(
           FiltrKey.new("admin/authority/user_authorities", "search_user_authorities", "authorize_roles"),
           nil,
           FiltrActionURL.new("v.admin_authority_search_user_authorities_path", '', {:method => :get, :turbolinks => true}),
           "Admin::Authority::Role.with_all_belongs_included",         
           [InitialFiltr.new("id", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).as_array(:authorize_roles)", 
                             "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id])"),
            InitialFiltr.new("id", "-1", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]) and " + 
                             "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).as_array(:authorize_roles).blank?")
           ],
           FiltrMainAttr.new(:table, "", {}),
           [],
           [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'hide'}, {}),
            FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
            FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'unhide'}, {}),
            FieldsDesc.new(3, :role_type_id, :field, "Role type", "raw.role_type.name if raw.role_type", {:class => 'unhide'}, {}),
            FieldsDesc.new(4, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
            FieldsDesc.new(5, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
            ],
           [:id],
           FiltrNames.new(:user_authorities_page, :authorize_role_id, :authorize_roles_raw, :authorize_roles, :authorize_roles_head, :authorize_roles_body),
           FiltrPaginate.new(:authorize_roles_page, 5, {:class =>'pagination pagination-centered', :param_name=> :authorize_roles_page}),
           :check
           ),
           
        FiltrParam.new(
           FiltrKey.new("admin/authority/user_authorities", "search_user_authorities", "own_crud_roles"),
           nil,
           FiltrActionURL.new("v.admin_authority_search_user_authorities_path", '', {:method => :get, :turbolinks => true}),
           "Admin::Authority::Role.with_all_belongs_included",         
           [InitialFiltr.new("id", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).as_array(:own_crud_roles)", 
                             "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id])"),
            InitialFiltr.new("id", "-1", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]) and " + 
                             "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).as_array(:own_crud_roles).blank?")
           ],
           FiltrMainAttr.new(:table, "", {}),
           [],
           [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'hide'}, {}),
            FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
            FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'unhide'}, {}),
            FieldsDesc.new(3, :role_type_id, :field, "Role type", "raw.role_type.name if raw.role_type", {:class => 'unhide'}, {}),
            FieldsDesc.new(4, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
            FieldsDesc.new(5, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
            ],
           [:id],
           FiltrNames.new(:user_authorities_page, :own_crud_role_id, :own_crud_roles_raw, :own_crud_roles, :own_crud_roles_head, :own_crud_roles_body),
           FiltrPaginate.new(:own_crud_roles_page, 5, {:class =>'pagination pagination-centered', :param_name=> :own_crud_roles_page}),
           :check
           ),
  
        FiltrParam.new(
           FiltrKey.new("admin/authority/user_authorities", "search_user_authorities", "other_crud_roles"),
           nil,
           FiltrActionURL.new("v.admin_authority_search_user_authorities_path", '', {:method => :get, :turbolinks => true}),
           "Admin::Authority::Role.with_all_belongs_included",         
           [InitialFiltr.new("id", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).as_array(:other_crud_roles)", 
                             "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id])"),
            InitialFiltr.new("id", "-1", "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]) and " + 
                             "Admin::Authority::UserAuthority.find(session[:current_id][:user_authority_id]).as_array(:other_crud_roles).blank?")
           ],
           FiltrMainAttr.new(:table, "", {}),
           [],
           [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'hide'}, {}),
            FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
            FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'unhide'}, {}),
            FieldsDesc.new(3, :role_type_id, :field, "Role type", "raw.role_type.name if raw.role_type", {:class => 'unhide'}, {}),
            FieldsDesc.new(4, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
            FieldsDesc.new(5, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
            ],
           [:id],
           FiltrNames.new(:user_authorities_page, :other_crud_role_id, :other_crud_roles_raw, :other_crud_roles, :other_crud_roles_head, :other_crud_roles_body),
           FiltrPaginate.new(:other_crud_roles_page, 5, {:class =>'pagination pagination-centered', :param_name=> :other_crud_roles_page}),
           :check
           ),
      ]
      
    end
  end
end  