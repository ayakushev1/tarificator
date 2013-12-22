module FiltrDescriptions
  module Authority  
    module CheckingUrlAccessAuthorities
      include FiltrListStruct
  
      FILTR_PARAM = [
        FiltrParam.new(
           FiltrKey.new("admin/authority/url_access_authorities", "set_url_access_authorities", "url_access_authorities"),
           nil,
           FiltrActionURL.new("v.admin_authority_url_access_authorities_path", '', {:method => :get, :turbolinks => true}),
           "Admin::Authority::UrlAccessAuthority.with_all_belongs_included",         
           [],
           FiltrMainAttr.new(:table, "Setting url access authorities", {}),
           [FiltrSelectField.new(:controller, "", "Admin::Authority::UrlAccessAuthority.select(:controller).order(:controller).uniq", "admin_authority_url_access_authorities", :controller, :controller, "v.admin_authority_url_access_authorities_path", {}, {}),
            FiltrSelectField.new(:action, "", "Admin::Authority::UrlAccessAuthority.select(:action).order(:action).uniq", "admin_authority_url_access_authorities", :action, :action, "v.admin_authority_url_access_authorities_path", {}, {}),  
            FiltrSelectField.new(:restricted, "", "Admin::Authority::UrlAccessAuthority.select(:restricted).order(:restricted).uniq", "admin_authority_url_access_authorities", :restricted, :restricted, "v.admin_authority_url_access_authorities_path", {}, {}),  
            FiltrSelectField.new(:access_authorized_roles, "", "Admin::Authority::UrlAccessAuthority.select(:access_authorized_roles).order(:access_authorized_roles).uniq", "admin_authority_url_access_authorities", :access_authorized_roles, :access_authorized_roles, "v.admin_authority_url_access_authorities_path", {}, {}),  
            FiltrSelectField.new(:processed, "", "Admin::Authority::UrlAccessAuthority.select(:processed).order(:processed).uniq", "admin_authority_url_access_authorities", :processed, :processed, "v.admin_authority_url_access_authorities_path", {}, {}),  
           ],
           [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'hide'}, {}),
            FieldsDesc.new(1, :controller_path, :field, "Controller path", "raw.controller_path", {:class => 'unhide'}, {}),
            FieldsDesc.new(2, :route_path, :field, "Route path", "raw.route_path", {:class => 'hide'}, {}),
            FieldsDesc.new(3, :controller, :field, "Controller", "raw.controller", {:class => 'unhide'}, {}),
            FieldsDesc.new(4, :action, :field, "Action", "raw.action", {:class => 'unhide'}, {}),
            FieldsDesc.new(5, :restricted, :field, "Restricted", "raw.restricted", {:class => 'unhide'}, {}),
            FieldsDesc.new(6, :access_authorized_roles, :field, "Access authorized roles", "raw.access_authorized_roles", {:class => 'unhide'}, {}),
            FieldsDesc.new(7, :condition, :field, "Condition", "raw.condition", {:class => 'unhide'}, {}),
            FieldsDesc.new(8, :method_to_call_before_condition, :field, "Method to call before condition", "raw.method_to_call_before_condition", {:class => 'unhide'}, {}),
            FieldsDesc.new(9, :processed, :field, "Processed", "raw.processed", {:class => 'unhide'}, {}),
            FieldsDesc.new(10, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
            FieldsDesc.new(11, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
            FieldsDesc.new(12, :edit, :link_to_id, "", "v.link_to 'Edit', v.admin_authority_edit_url_access_authority_path(raw.id)", {:class => 'unhide'}, {}),
            FieldsDesc.new(13, :new, :link_to_id, "", "v.link_to 'New', v.admin_authority_new_url_access_authority_path", {:class => 'unhide'}, {}),
            FieldsDesc.new(14, :delete, :link_to_id, "", "v.link_to 'Delete', v.admin_authority_delete_url_access_authority_path(raw.id), data: {confirm: 'Are you sure?'}", {:class => 'unhide'}, {})
            ],
           [:id],
           FiltrNames.new(:url_access_authorities_filtr, :url_access_authorities_id, :url_access_authorities_raw, :url_access_authorities, :url_access_authorities_head, :url_access_authorities_body),
           FiltrPaginate.new(:url_access_authorities_page, 10, {:class =>'pagination pagination-centered', :param_name=> :url_access_authorities_page}),
           :check
           ),         
  
        FiltrParam.new(
           FiltrKey.new("admin/authority/url_access_authorities", "edit_url_access_authority", "edit_url_access_authority"),
           nil,
           FiltrActionURL.new("v.admin_authority_update_url_access_authority_path(:id)", "v.admin_authority_edit_url_access_authority_path(:id)", {:method => :get, :turbolinks => true}),
           "Admin::Authority::UrlAccessAuthority.find(params[:id])", 
           [],
           FiltrMainAttr.new(:form, "Editting url access authority", {}),
           [#FiltrSelectField.new(:schedule_state_id, "Schedule state", "Admin::State.game_sсhedule_states", "admin_states", :id, :name, "v.admin_authority_update_url_access_authority_path(:id)", {:class => 'hide'}, {:class => 'hide'}),
            ],
           [FieldsDesc.new(0, :id, :model_field, "Id", "v.text_field(raw, :id, options)", {:class => 'hide'}, {:class => 'hide'}),
            FieldsDesc.new(1, :controller_path, :model_field, "Controller path", "v.text_field(raw, :controller_path, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(2, :controller, :model_field, "Controller", "v.text_field(raw, :controller, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(3, :action, :model_field, "Action", "v.text_field(raw, :action, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(4, :restricted, :model_field, "Restricted", "v.check_box(raw, :restricted, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(5, :access_authorized_roles, :model_field, "Access authorized roles", "v.text_field(raw, :access_authorized_roles, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(6, :condition, :model_field, "Condition", "v.text_field(raw, :condition, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(7, :method_to_call_before_condition, :model_field, "Method to call before condition", "v.text_field(raw, :method_to_call_before_condition, options)", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(8, :processed, :model_field, "Processed", "v.check_box(raw, :processed, options )", {:class => 'unhide'}, {:class => 'unhide'}),
            FieldsDesc.new(9, :created_at, :model_field, "Created at", "v.text_field(raw, :created_at, options)", {:class => 'hide'}, {:class => 'hide'}),
            FieldsDesc.new(10, :updated_at, :model_field, "Updated at", "v.text_field(raw, :updated_at, options)", {:class => 'hide'}, {:class => 'hide'}),
            FieldsDesc.new(11, :submit_button, :model_field, "", "v.submit_tag('', options )", {:class => 'unhide', :turbolinks => true, :value => "Save"}, {:class => 'unhide'}), 
            FieldsDesc.new(12, :back, :model_field, "", "v.link_to 'Back', v.admin_authority_url_access_authorities_path", {:class => 'unhide'}, {:class => 'unhide'}),
            ],
           [],
           FiltrNames.new(:url_access_authority_filtr, nil, nil, :url_access_authority, nil, nil),
           nil,
           :check
           ),
  
        FiltrParam.new(
           FiltrKey.new("admin/authority/url_access_authorities", "new_url_access_authority", "new_url_access_authority"),
           SubstitutingFiltrParams.new(FiltrKey.new("admin/authority/url_access_authorities", "edit_url_access_authority", "edit_url_access_authority"),
            [{:param => :fields_desc, :substitute_type => :join_and_original_preferred},
             ]),
           FiltrActionURL.new("v.admin_authority_create_url_access_authority_path", "v.admin_authority_new_url_access_authority_path", {:method => :get, :turbolinks => true}),
           "Admin::Authority::UrlAccessAuthority.new", 
           [],
           FiltrMainAttr.new(:form, "New url access authority", {}),
           [#FiltrSelectField.new(:schedule_state_id, "Schedule state", "Admin::State.game_sсhedule_states", "admin_states", :id, :name, "/games/search_activities", {:class => 'hide'}, {:class => 'hide'}),
            ],
           [#FieldsDesc.new(12, :back, :tag_field, "", "v.link_to 'Back_1', v.admin_authority_url_access_authorities_path", {:class => 'unhide'}, {:class => 'unhide'}),
            ],
           [],
           FiltrNames.new(:url_access_authority_filtr, nil, nil, :url_access_authority, nil, nil),
           nil,
           :check
           ),
      ]
    
    end
  end
end  