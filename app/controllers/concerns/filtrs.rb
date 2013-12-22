module Filtrs
  
  class Filtr
#    extend ActiveSupport
    include FiltrDescriptions::FiltrList
    
    attr_reader :model_raws_to_show, :filtr, :model, :modules, :c, :v, :p, :p_subed
    
    class FiltrInitializeException < Exception; end
    
    def initialize(context, model_name, *optional_action_name)
      
      @c = context
      @v = @c.view_context
      @model_name = model_name
      
      if optional_action_name.length > 0
        action_name = optional_action_name[0]
      else
        action_name = @c.action_name
      end
      
      @p = init_param(@c.controller_path, action_name, @model_name)
      raise FiltrInitializeException, "Wrong model name, #{@model_name}, in #{@c.controller_path}/#{@c.action_name}" unless @p
      raise FiltrInitializeException, "Wrong filtr param, #{@model_name}, in #{@c.controller_path}/#{@c.action_name}" unless p[:check] == :check
      

      @filtr_fields = p[:filtr_select_fields]
      @fields_desc = p[:fields_desc]
      @filtr_names = p[:filtr_names]
      if p[:model_init_string]
        init_session_for_filtr
        @model = eval(p[:model_init_string], @c.getBinding)
        raise FiltrInitializeException, "Wrong model init string, #{@model_name}, in #{@c.controller_path}/#{@c.action_name}" unless @model
      end   
      @filtr_main_attr = p[:filtr_main_attr]
      @filtr = {}
      @fields_to_hide = {}
      @initial_filtr = @p.to_sql_condition(@c.getBinding)
      
      make_initial_setup      
      
      self.extend FiltrPresenters::Presenter
      self.extend DateTimeHelper
    end

#    delegate :session, :to => @c.session
    
    def init_param(controller_name, action_name, model_name)
      original = find_filtr_param(controller_name, action_name, model_name)
      raise FiltrInitializeException, "Wrong model name, #{model_name}, in #{controller_name}/#{action_name}" unless original
      return original unless original[:substituting_filtr_params]
      substitute = FILTR_PARAM.find{|x| x if x[:key]==original[:substituting_filtr_params][:key]}
      original[:substituting_filtr_params][:params_to_substitute].each do |sub|
        case sub[:substitute_type]
        when :substitute_only
          original[sub[:param]] = substitute[sub[:param]] 
        when :join_and_substitute_preferred
          if original[sub[:param]]
            original[sub[:param]] = join_and_substitute_preferred(original[sub[:param]], substitute[sub[:param]], sub[:param])
          else
            original[sub[:param]] = substitute[sub[:param]]
          end           
        when :join_and_original_preferred
          if original[sub[:param]]
            original[sub[:param]] = join_and_original_preferred(original[sub[:param]], substitute[sub[:param]], sub[:param])
          else
            original[sub[:param]] = substitute[sub[:param]]
          end           
        else
          raise FiltrInitializeException, "Wrong substitute type, #{sub[:substitute_type]}, while initializing FiltrParams in #{c.controller_path}/#{c.action_name}"
        end
      end
      original
    end
    
    def join_and_substitute_preferred(original_param, substitute_param, param)
      case param
      when :key, :substituting_filtr_params, :action_url_after_submit, :check
         raise FiltrInitializeException, "You cannot substitute param, #{param}, while initializing FiltrParams in #{c.controller_path}/#{c.action_name}"
      when :model_init_string, :filtr_main_attr, :filtr_names, :paginate_param
        substitute_param ? substitute_param : original_param
      when :initial_filtr
        merging_arrays_of_hashes_by_field(substitute_param, original_param, :model_field)
      when :filtr_select_fields
        merging_arrays_of_hashes_by_field(substitute_param, original_param, :filtr_field)
      when :fields_desc
        merging_arrays_of_hashes_by_field(substitute_param, original_param, :field)
      when :order_fields
        substitute_param + original_param.select{|x| substitute_param.include?(x) }
      else
        raise FiltrInitializeException, "Wrong substitute param, #{param}, while initializing FiltrParams in #{c.controller_path}/#{c.action_name}"
      end
    end      
    
    def join_and_original_preferred(original_param, substitute_param, param)
      case param
      when :key, :substituting_filtr_params, :action_url_after_submit, :check
         raise FiltrInitializeException, "You cannot substitute param, #{param}, while initializing FiltrParams in #{c.controller_path}/#{c.action_name}"
      when :model_init_string, :filtr_main_attr, :filtr_names, :paginate_param
        original_param
      when :initial_filtr
        merging_arrays_of_hashes_by_field(original_param, substitute_param, :model_field)
      when :filtr_select_fields
        merging_arrays_of_hashes_by_field(original_param, substitute_param, :filtr_field)
      when :fields_desc
        merging_arrays_of_hashes_by_field(original_param, substitute_param, :field)
      when :order_fields
        original_param + substitute_param.select{|x| original_param.include?(x) }
      else
        raise FiltrInitializeException, "Wrong substitute param, #{param}, while initializing FiltrParams in #{c.controller_path}/#{c.action_name}"
      end
    end      
    
    def merging_arrays_of_hashes_by_field(main_array, additional_array, field)
      substitute_fields = main_array.collect{|x| x[field]}
      main_array + additional_array.select{|x| !substitute_fields.include?(x[field]) }
    end
    
    def c_tag(*args, &block)
      v.content_tag(*args, &block)
    end
  
    def make_initial_setup
      set_session_filtr      
      make_initial_setup_for_filtr_list      
      check_if_session_data_correct
    end
    
    def make_initial_setup_for_filtr_list
      make_initial_setup_for_filtr_list_of_type_table if @filtr_main_attr[:filtr_query_type] == :table      
      make_initial_setup_for_filtr_list_of_type_form if @filtr_main_attr[:filtr_query_type] == :filtr_field      
      make_initial_setup_for_filtr_list_of_type_form if @filtr_main_attr[:filtr_query_type] == :filtr_fields      
      make_initial_setup_for_filtr_list_of_type_form if @filtr_main_attr[:filtr_query_type] == :form            
    end
    
    def make_initial_setup_for_filtr_list_of_type_form
      init_model_for_filtr_field_select_options
    end
    
    def init_model_for_filtr_field_select_options
      @filtr_fields.each do |filtr_field|
        filtr_model = eval(filtr_field[:look_up_model], @c.getBinding) if filtr_field[:look_up_model]
        @filtr[filtr_field[:filtr_field] ] = filtr_model               
      end
    end
    
    def make_initial_setup_for_filtr_list_of_type_table
      init_model_raw_to_show_without_paginate
      set_current_paginate_page      
      init_model_raw_to_show                               
      set_session_current_id                                                             
      make_filtr_select_options      
    end
    
   def init_model_raw_to_show_without_paginate
      checked_session = @model.check_filtr_for_model_fields(@c.session[:filtr][@filtr_names[:filtr_name]])
      @model_raws_to_show_without_paginate = @model.make_filtr(checked_session).order(p[:order_fields])     

      unless @model_raws_to_show_without_paginate
        raise FiltrInitializeException, "Wrong model init of model raw to show, #{@model}, in #{@c.controller_path}/#{@c.action_name}"
      end           
   end

    def set_current_paginate_page
      @c.session[:current_paginate_page] ||={} #unless @c.session[:current_paginate_page]
      @c.session[:current_paginate_page][@p.paginate_name] = 1 unless @c.session[:current_paginate_page][@p.paginate_name]
      
      @c.session[:current_paginate_page][@p.paginate_name] = @c.params[@p.paginate_name] if @c.params[@p.paginate_name]      
      @c.session[:current_paginate_page][@p.paginate_name] = 1 if @c.params[:filtr] and @c.params[:filtr][:filtr_name]
    end
    
    def init_model_raw_to_show
      @model_raws_to_show = @model_raws_to_show_without_paginate
        .paginate(page: @c.session[:current_paginate_page][@p.paginate_name], :per_page => p[:paginate_param][:paginate_per_page]) 

      unless @model_raws_to_show
        raise FiltrInitializeException, "Wrong model init of model raw to show, #{@model}, in #{@c.controller_path}/#{@c.action_name}"
      end           
    end
    
    def set_session_current_id
      current_id_name = @filtr_names[:current_id_name]      
      
      init_session_current_id      
            
      @c.session[:current_id][current_id_name] = first_model_raw_to_show_raw if @c.params[:filtr]      
      @c.session[:current_id][current_id_name] = first_model_raw_to_show_raw if @c.params[@p.paginate_name]

      if @c.params[:current_id] and @c.params[:current_id][current_id_name] and !(@c.params[@p.paginate_name])
        @c.session[:current_id][current_id_name] = @c.params[:current_id][current_id_name]
      end
      
      if @c.session[:current_id][current_id_name]
        if check_if_model_raw_to_show_not_include_current_id
          if @model_raws_to_show_without_paginate.count == 0
            @c.session[:current_id][current_id_name] = first_model_raw_to_show_raw
          else
            @c.session[:current_paginate_page][@p.paginate_name] = 1
            init_model_raw_to_show
            @c.session[:current_id][current_id_name] = first_model_raw_to_show_raw
          end
          
        else
          @c.session[:current_paginate_page][@p.paginate_name] = search_current_paginate_page(@c.session[:current_id][current_id_name])
          init_model_raw_to_show
        end                          
      else
        @c.session[:current_id][current_id_name] = first_model_raw_to_show_raw
      end
      
    end
    
    def check_if_model_raw_to_show_not_include_current_id
      if @model_raws_to_show_without_paginate.where(:id => @c.session[:current_id][@filtr_names[:current_id_name]]).count == 0
        true
      else
        false  
      end
    end

    def init_session_current_id
      @c.session[:current_id] = {} unless @c.session[:current_id]
    end
    
    def search_current_paginate_page(current_id)
      result = 1
      i = 0
      @model_raws_to_show_without_paginate.each do |raw|
        if raw.id == current_id.to_i
          result = (i / p[:paginate_param][:paginate_per_page]).to_int + 1
          break
        end
        i += 1
      end
      result
    end
    
    def first_model_raw_to_show_raw
      result = -1
      @model_raws_to_show.first.id if @model_raws_to_show.first
    end
            
    def make_filtr_select_options
      @filtr_fields.each do |filtr_field|
        @filtr[filtr_field[:filtr_field]] = make_one_filtr_select_option(filtr_field)  
      end
    end
    
    def make_one_filtr_select_option(filtr_field)
      filtr_values = @c.session[:filtr][@filtr_names[:filtr_name] ]      
      field = filtr_field[:filtr_field]
      
      filtr_values_without_selected_field = {}
      filtr_values.each {|key, value| filtr_values_without_selected_field[key] = value unless key==field}

      checked_filtr_values_without_selected_field = @model.check_filtr_for_model_fields(filtr_values_without_selected_field)

      
      field_ids = @model.make_field_values(field, checked_filtr_values_without_selected_field)
    
      filtr_select_fields = [filtr_field[:look_up_query]+"."+filtr_field[:look_up_id_field].to_s,
                             filtr_field[:look_up_query]+"."+filtr_field[:look_up_name_field].to_s]
                           
      filtr_id_field = filtr_field[:look_up_query]+"."+filtr_field[:look_up_id_field].to_s
      
#      filtr_model = filtr_field[:look_up_model].constantize
      filtr_model = eval(filtr_field[:look_up_model])
      
      filtr_model.make_filtr_select_options(filtr_select_fields, filtr_id_field, field_ids)  
    end
    
    def set_session_filtr
      init_session_for_filtr      
      add_model_initial_filtr_to_session_filtr      
      update_with_model_values if @model and @filtr_main_attr[:filtr_query_type] == :form
      add_params_to_session_filtr      
    end     
    
    def init_session_for_filtr
      @c.session[:filtr]={} unless @c.session[:filtr] 
      @c.session[:filtr][@filtr_names[:filtr_name] ]={} unless @c.session[:filtr][@filtr_names[:filtr_name] ]      
    end
    
    def add_model_initial_filtr_to_session_filtr
      @initial_filtr.each { |key, val| @c.session[:filtr][ @filtr_names[:filtr_name] ][key]=val}       
    end
    
    def update_with_model_values
      add_model_values unless @c.session[:filtr][ @filtr_names[:filtr_name] ]
      add_model_values unless @c.session[:filtr][ @filtr_names[:filtr_name] ][:id] == @model[:id].to_s
    end
    
    def add_model_values      
      @fields_desc.each do |filtr_field| 
        field_name = filtr_field[:field]
        @c.session[:filtr][ @filtr_names[:filtr_name] ][field_name] = @model[field_name]
      end
    end
    
    def add_params_to_session_filtr
      model_symbol_in_filtr=@filtr_names[:filtr_name] #like :games_filtr
      
      if @c.params[model_symbol_in_filtr]
        @c.params[model_symbol_in_filtr].each do |i|
          if i[1].nil? or i[1].empty?
            @c.session[:filtr][model_symbol_in_filtr][i[0].to_sym]=nil
          else
            @c.session[:filtr][model_symbol_in_filtr][i[0].to_sym]=i[1]
          end                     
        end  
      end              
    end
    
    def check_if_session_data_correct
      @c.session[:filtr][@filtr_names[:filtr_name]].each do |field|
        if @p.filtr_select_field_desc(field[0])
          id_name = @p.filtr_select_field_desc(field[0])[:look_up_id_field]          
          @c.session[:filtr][@filtr_names[:filtr_name]][field[0]] = nil unless @filtr[field[0]].where(id_name => field[1]).exists?
        end
      end
    end 
   
  end
  
  
  

end