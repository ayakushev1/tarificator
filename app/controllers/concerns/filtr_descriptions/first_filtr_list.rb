module FiltrDescriptions
  module FirstFiltrList
    include FiltrListStruct
    
    FILTR_PARAM = 
     [
      FiltrParam.new(
         FiltrKey.new("sessions", "new", "login"),
         nil,
         FiltrActionURL.new("v.submit_login_path", "v.login_path", {:method => :post, :turbolinks => true}),
         nil, 
         [],
         FiltrMainAttr.new(:form, "Please Log In", {}),
         [],
         [FieldsDesc.new(0, :name, :model_field, "Name", "v.text_field(raw, :name, options)", {}, {}),
          FieldsDesc.new(1, :password, :model_field, "Password", "v.text_field(raw, :password, options)", {:type => 'password'}, {}),
          FieldsDesc.new(2, :submit_button, :model_field, "", "v.submit_tag('', options )", {:class => 'unhide', :turbolinks => true, :value => "Login"}, {:class => 'unhide'}), 
          ],
         [],
         FiltrNames.new(:login_filtr, nil, nil, :login, nil, nil),
         nil,
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("sessions", "new_place", "place"),
         nil,
         FiltrActionURL.new("v.set_new_place_path", "v.new_place_path", {:method => :get, :turbolinks => true}),
         nil, 
         [],
         FiltrMainAttr.new(:form, "New place", {}),
         [FiltrSelectField.new(:place_type_id, "Place type", "Admin::PlaceType.all", "admin_place_types", :id, :name, "v.new_place_path", {:class => 'unhide'}, {}),
          FiltrSelectField.new(:place_id, "Place", "Admin::Place.main_places.where({:place_type_id => session[:filtr][:place_filtr][:place_type_id], :location_id => session[:location][:city_id]} )", "admin_places", :id, :name, "v.new_place_path", {:class => 'unhide'}, {})
          ],
         [FieldsDesc.new(0, :place_type_id, :filtr_select_field, "", "", {}, {}),
          FieldsDesc.new(1, :place_id, :filtr_select_field, "", "", {}, {}),
          FieldsDesc.new(2, :submit_button, :model_field, "", "v.submit_tag('', options )", {:class => 'unhide', :turbolinks => true, :value => "Choose"}, {:class => 'unhide'}), 
          ],
         [],
         FiltrNames.new(:place_filtr, nil, nil, :user_place, nil, nil),
         nil,
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("sessions", "new_location", "location"),
         nil,
         FiltrActionURL.new("v.set_new_location_path", "v.new_location_path", {:method => :get, :turbolinks => true}),
         nil, 
         [],
         FiltrMainAttr.new(:form, "New location", {}),
         [FiltrSelectField.new(:country_id, "Country", "Admin::Location.where(:location_type_id => 2)", "admin_locations", :id, :name, "v.new_location_path", {}, {}),
          FiltrSelectField.new(:region_id, "Region", "Admin::Location.where(:location_id => session[:filtr][:location_filtr][:country_id])", "admin_locations", :id, :name, "v.new_location_path", {}, {}),
          FiltrSelectField.new(:city_id, "City", "Admin::Location.where(:location_id => session[:filtr][:location_filtr][:region_id])", "admin_locations", :id, :name, "v.new_location_path", {}, {}) 
          ],
         [FieldsDesc.new(0, :country_id, :filtr_select_field, "", "", {}, {}),
          FieldsDesc.new(1, :region_id, :filtr_select_field, "", "", {}, {}),
          FieldsDesc.new(2, :city_id, :filtr_select_field, "", "", {}, {}),
          FieldsDesc.new(3, :submit_button, :model_field, "", "v.submit_tag('', options )", {:class => 'unhide', :turbolinks => true, :value => "Choose"}, {:class => 'unhide'}), 
          ],
         [],
         FiltrNames.new(:location_filtr, nil, nil, :user_location, nil, nil),
         nil,
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("games", "index", "games"),
         nil,
         FiltrActionURL.new('v.games_path', "v.games_path", {:method => :get, :turbolinks => true}),
         "Game.joins(place: :location).merge(Admin::Location.chosen_location(session[:location][:city_id]) )", 
         [InitialFiltr.new("place_id", "session[:admin_place][:place_type_id]", "session[:admin_place]")
         ],
         FiltrMainAttr.new(:table, "Games", {}),
         [FiltrSelectField.new(:activity_id, "", "Admin::Activity", "admin_activities", :id, :name, "v.games_path", {}, {}),
          FiltrSelectField.new(:place_id, "", "Admin::Place", "admin_places", :id, :name, "v.games_path", {}, {}), 
          FiltrSelectField.new(:game_place_id, "", "Admin::Place", "admin_places", :id, :name, "v.games_path", {}, {}),
          FiltrSelectField.new(:initiator_id, "", "User", "users", :id, :name, "v.games_path", {}, {}),
          FiltrSelectField.new(:state_id, "", "Admin::State", "admin_states", :id, :name, "v.games_path", {}, {})
          ],
         [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'unhide'}, {}),
          FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
          FieldsDesc.new(2, :activity_id, :field, "Activity", "raw.activity.name if raw.activity", {:class => 'unhide'}, {}),
          FieldsDesc.new(3, :place_id, :field, "Place", "raw.place.name if raw.place", {:class => 'unhide'}, {}),
          FieldsDesc.new(4, :game_place_id, :field, "Game place", "raw.game_place.name if raw.game_place", {:class => 'unhide'}, {}),
          FieldsDesc.new(5, :initiator_id, :field, "Initiator", "raw.initiator.name if raw.initiator", {:class => 'unhide'}, {}),
          FieldsDesc.new(6, :state_id, :field, "Game state", "raw.state.name if raw.state", {:class => 'unhide'}, {}),
          FieldsDesc.new(7, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
          FieldsDesc.new(8, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}), 
          FieldsDesc.new(9, :new, :link_to_id, "", "v.link_to 'New', v.new_game_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(10, :show, :link_to_id, "", "v.link_to 'Show', v.game_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(11, :edit, :link_to_id, "", "v.link_to 'Edit', v.edit_game_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(12, :destroy, :link_to_id, "", "v.link_to 'Destroy', raw, method: :delete, data: {confirm: 'Are you sure?'}", {:class => 'unhide'}, {})
          ],
         [:id],
         FiltrNames.new(:games_filtr, :game_id, :game_index_raw, :game_index, :game_index_head, :game_index_body),
         FiltrPaginate.new(:games_page, 5, {:class =>'pagination pagination-centered', :param_name=> :games_page}),
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("games", "index", "schedules"),
         nil,
         FiltrActionURL.new("v.games_path", "v.games_path", {:method => :get, :turbolinks => true}),
         "Schedule", 
         [InitialFiltr.new("game_id", "session[:current_id][:game_id]", "session[:current_id]")
         ],
         FiltrMainAttr.new(:table, "Schedules", {}),
         [FiltrSelectField.new(:precision_type_id, "", "Admin::Type", "admin_types", :id, :name, "v.games_path", {}, {})
         ],
         [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'unhide'}, {}),
          FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'hide'}, {}),
          FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'hide'}, {}),
          FieldsDesc.new(3, :game_id, :field, "Game", "raw.game.id if raw.game", {:class => 'unhide'}, {}),
          FieldsDesc.new(4, :precision_type_id, :field, "Precision", "raw.precision_type.name if raw.precision_type", {:class => 'unhide'}, {}),
          FieldsDesc.new(5, :periodicity_type_id, :field, "Periodicity", "raw.periodicity_type.name if raw.periodicity_type", {:class => 'unhide'}, {}),
          FieldsDesc.new(6, :schedule_state_id, :field, "Schedulte state", "raw.schedule_state.name if raw.schedule_state", {:class => 'unhide'}, {}),
          FieldsDesc.new(7, :start_of_schedule, :field, "Start of schedule", "raw.start_of_schedule.strftime('%d %b %y') if raw.start_of_schedule", {:class => 'unhide'}, {}),
          FieldsDesc.new(8, :end_of_schedule, :field, "End of Schedule", "raw.end_of_schedule.strftime('%d %b %y') if raw.end_of_schedule", {:class => 'unhide'}, {}),
          FieldsDesc.new(9, :duration_of_schedule, :field, "Duration of schedule", "v.pluralize(raw.duration_of_schedule, 'day')", {:class => 'unhide'}, {}),
          FieldsDesc.new(10, :creator_id, :field, "Creator", "raw.creator.name", {:class => 'unhide'}, {}),
          FieldsDesc.new(11, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
          FieldsDesc.new(12, :updated_at, :field, "Update at", "raw.updated_at", {:class => 'hide'}, {}), 
          FieldsDesc.new(13, :new, :link_to_id, "", "v.link_to 'New', v.new_schedule_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(14, :show, :link_to_id, "", "v.link_to 'Show', v.schedule_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(15, :edit, :link_to_id, "", "v.link_to 'Edit', v.edit_schedule_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(16, :destroy, :link_to_id, "", "v.link_to 'Destroy', raw, method: :delete, data: {confirm: 'Are you sure?'}", {:class => 'unhide'}, {})
          ],
         [:id],
         FiltrNames.new(:schedules_filtr, :schedule_id, :schedule_index_raw, :schedule_index, :schedule_index_head, :schedule_index_body),
         FiltrPaginate.new(:schedules_page, 5, {:class =>'pagination pagination-centered', :param_name=> :schedules_page}),
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("games", "index", "schedule_details"),
         nil,
         FiltrActionURL.new("v.games_path", "v.games_path", {:method => :get, :turbolinks => true}),
         "ScheduleDetail", 
         [InitialFiltr.new("schedule_id", "session[:current_id][:schedule_id]", "session[:current_id]")
         ],
         FiltrMainAttr.new(:table, "Schedule details", {}),
         [],
         [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'unhide'}, {}),
          FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'hide'}, {}),
          FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'hide'}, {}),
          FieldsDesc.new(3, :schedule_id, :field, "Schedule", "raw.schedule.id if raw.schedule", {:class => 'unhide'}, {}), 
          FieldsDesc.new(4, :on_schedule_date, :field, "On schedule date", "raw.on_schedule_date", {:class => 'unhide'}, {}),
          FieldsDesc.new(5, :periodic_week_day_id, :field, "Periodic week day", "raw.periodic_week_day.name if raw.periodic_week_day", {:class => 'unhide'}, {}),
          FieldsDesc.new(6, :time_start, :field, "Start time", "raw.time_start.strftime('%H:%M') if raw.time_start", {:class => 'unhide'}, {}),
          FieldsDesc.new(7, :time_end, :field, "End time", "raw.time_end.strftime('%H:%M') if raw.time_end", {:class => 'unhide'}, {}),
          FieldsDesc.new(8, :time_duration, :field, "Duration", "raw.time_duration", {:class => 'unhide'}, {}),
          FieldsDesc.new(9, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
          FieldsDesc.new(10, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}),
          FieldsDesc.new(11, :new, :link_to_id, "", "v.link_to 'New', v.new_schedule_detail_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(12, :show, :link_to_id, "", "v.link_to 'Show', v.schedule_detail_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(13, :edit, :link_to_id, "", "v.link_to 'Edit', v.edit_schedule_detail_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(14, :destroy, :link_to_id, "", "v.link_to 'Destroy', raw, method: :delete, data: {confirm: 'Are you sure?'}", {:class => 'unhide'}, {})
         ],
         [:id],
         FiltrNames.new(:schedule_details_filtr, :schedule_detail_id, :schedule_detail_index_raw, :schedule_detail_index, :schedule_detail_index_head, :schedule_detail_index_body),
         FiltrPaginate.new(:schedule_details_page, 5, {:class =>'pagination pagination-centered', :param_name=> :schedule_details_page}),
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("admin/places", "index", "admin_places"),
         nil,
         FiltrActionURL.new("v.admin_places_path", "v.admin_places_path", {:method => :get, :turbolinks => true}),
         "Admin::Place.with_all_belongs_included", 
         [InitialFiltr.new("location_id", "session[:location][:city_id]", "session[:location]")
         ],
         FiltrMainAttr.new(:table, "Places", {}),
         [FiltrSelectField.new(:place_type_id, "", "Admin::PlaceType", "admin_place_types", :id, :name, "v.admin_places_path", {}, {}),
          FiltrSelectField.new(:place_id, "", "Admin::Place", "admin_places", :id, :name, "v.admin_places_path", {}, {}),
          FiltrSelectField.new(:location_id, "", "Admin::Location", "admin_locations", :id, :name, "v.admin_places_path", {}, {}),
          FiltrSelectField.new(:activity_id, "", "Admin::Activity", "admin_activities", :id, :name, "v.admin_places_path", {}, {}) 
         ],
         [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'hide'}, {}),
          FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
          FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'unhide'}, {}),
          FieldsDesc.new(3, :place_type_id, :field, "Place type", "raw.place_type.name if raw.place_type", {:class => 'unhide'}, {}), 
          FieldsDesc.new(4, :place_id, :field, "Place", "raw.place.name if raw.place", {:class => 'hide'}, {}),
          FieldsDesc.new(5, :location_id, :field, "Location", "raw.location.name if raw.location", {:class => 'unhide'}, {}),
          FieldsDesc.new(6, :activity_id, :field, "Activity", "raw.activity.name if raw.activity", {:class => 'hide'}, {}),
          FieldsDesc.new(7, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
          FieldsDesc.new(8, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}),
          FieldsDesc.new(9, :new, :link_to_id, "", "v.link_to 'New', v.new_admin_place_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(10, :show, :link_to_id, "", "v.link_to 'Show', v.admin_place_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(11, :edit, :link_to_id, "", "v.link_to 'Edit', v.edit_admin_place_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(12, :destroy, :link_to_id, "", "v.link_to 'Destroy', raw, method: :delete, data: {confirm: 'Are you sure?'}", {:class => 'unhide'}, {})
         ],
         [:id],
         FiltrNames.new(:admin_places_filtr, :admin_place_id, :admin_place_index_raw, :admin_place_index, :admin_place_index_head, :admin_place_index_body),
         FiltrPaginate.new(:admin_place_page, 5, {:class =>'pagination pagination-centered', :param_name=> :admin_places_page}),
         :check
         ),
         
      FiltrParam.new(
         FiltrKey.new("admin/places", "index", "admin_child_places"),
         nil,
         FiltrActionURL.new("v.admin_places_path", "v.admin_places_path", {:method => :get, :turbolinks => true}),
         "Admin::Place.with_all_belongs_included", 
         [InitialFiltr.new("place_id", "session[:current_id][:admin_place_id]", "session[:current_id]")
         ],
         FiltrMainAttr.new(:table, "Child places", {}),
         [FiltrSelectField.new(:place_type_id, "", "Admin::PlaceType", "admin_place_types", :id, :name, "v.admin_places_path", {}, {}),
          FiltrSelectField.new(:place_id, "", "Admin::Place", "admin_places", :id, :name, "v.admin_places_path", {}, {}),
          FiltrSelectField.new(:location_id, "", "Admin::Location", "admin_locations", :id, :name, "v.admin_places_path", {}, {}),
          FiltrSelectField.new(:activity_id, "", "Admin::Activity", "admin_activities", :id, :name, "v.admin_places_path", {}, {}) 
         ],
         [FieldsDesc.new(0, :id, :field, "Id", "raw.id", {:class => 'unhide'}, {}),
          FieldsDesc.new(1, :name, :field, "Name", "raw.name", {:class => 'unhide'}, {}),
          FieldsDesc.new(2, :description, :field, "Description", "raw.description", {:class => 'unhide'}, {}),
          FieldsDesc.new(3, :place_type_id, :field, "Place type", "raw.place_type.name if raw.place_type", {:class => 'unhide'}, {}), 
          FieldsDesc.new(4, :place_id, :field, "Place", "raw.place.name if raw.place", {:class => 'hide'}, {}),
          FieldsDesc.new(5, :location_id, :field, "Location", "raw.location.name if raw.location", {:class => 'hide'}, {}),
          FieldsDesc.new(6, :activity_id, :field, "Activity", "raw.activity.name if raw.activity", {:class => 'unhide'}, {}),
          FieldsDesc.new(7, :created_at, :field, "Created at", "raw.created_at", {:class => 'hide'}, {}),
          FieldsDesc.new(8, :updated_at, :field, "Updated at", "raw.updated_at", {:class => 'hide'}, {}),
          FieldsDesc.new(9, :new, :link_to_id, "", "v.link_to 'New', v.new_admin_place_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(10, :show, :link_to_id, "", "v.link_to 'Show', v.admin_place_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(11, :edit, :link_to_id, "", "v.link_to 'Edit', v.edit_admin_place_path(raw.id)", {:class => 'unhide'}, {}),
          FieldsDesc.new(12, :destroy, :link_to_id, "", "v.link_to 'Destroy', raw, method: :delete, data: {confirm: 'Are you sure?'}", {:class => 'unhide'}, {})
         ],
         [:id],
         FiltrNames.new(:admin_child_places_filtr, :admin_child_place_id, :admin_child_place_index_raw, :admin_child_place_index, :admin_child_place_index_head, :admin_child_place_index_body),
         FiltrPaginate.new(:admin_child_place_page, 5, {:class =>'pagination pagination-centered', :param_name => :admin_child_places_page}),
         :check
         ),
    ]
    
  
  end
end