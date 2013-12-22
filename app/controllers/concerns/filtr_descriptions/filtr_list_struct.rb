module FiltrDescriptions
  module FiltrListStruct
    extend ActiveSupport::Concern
  
  # special words = {
  #  v - refer to view object,
  #  raw - refer to raw of ActiveRecord
  #  }  
    FiltrKey = Struct.new(:controller, :action, :model)
    SubstitutingFiltrParams = Struct.new(:key, :params_to_substitute)
    ParamsToSubsitute = Struct.new(:param, :substitute_type) #substitute_type = {:substitute_only, :join_and_subsitute_preferred, :join_and_original_preferred}
    FiltrActionURL = Struct.new(:action, :action_after_field_update, :form_attr)
    InitialFiltr = Struct.new(:model_field, :filtr_value, :filtr_if_condition)
    FiltrMainAttr = Struct.new(:filtr_query_type, :filtr_caption, :main_filtr_attr)
  # :filtr_query_type = [:table, :form]
  # :main_filtr_attr = [:hide_field_if_in_external_filtr_not_nil - valid only for :list] 
    FiltrSelectField = Struct.new(:filtr_field, :filtr_caption, :look_up_model, :look_up_query, :look_up_id_field, :look_up_name_field, :action_url_after_update ,:filtr_field_attributes, :filtr_caption_attributes)
    FieldsDesc = Struct.new(:order, :field, :field_type, :field_caption, :field_name_formula ,:field_attributes, :caption_attributes)
  # :field_type = [:filtr_select_field, :text_field, :tag] 
    FiltrPaginate = Struct.new(:paginate_name, :paginate_per_page, :paginate_attributes) 
    FiltrNames = Struct.new(:filtr_name, :current_id_name, :raw_name, :table_name, :table_head_name, :table_body_name)
  # :filtr_name should include "filtr", :raw_name - "raw"  
    FiltrParam = Struct.new(:key, 
                            :substituting_filtr_params,
                            :action_url_after_submit,
                            :model_init_string, 
                            :initial_filtr, 
                            :filtr_main_attr, 
                            :filtr_select_fields, 
                            :fields_desc,
                            :order_fields, 
                            :filtr_names,
                            :paginate_param,
                            :check ) do
      def to_sql_condition(context) 
        s = {}
        self[:initial_filtr].each do |i|
          if i.filtr_if_condition == ""
            condition = true
          else
            condition = eval(i.filtr_if_condition, context)
          end   
          
          if condition
            if (i.filtr_value.class == Fixnum) or (i.filtr_value == nil)
              s[i.model_field] = i.filtr_value if condition
            else
              s[i.model_field] = eval(i.filtr_value, context)
            end
          end
        end
        s
      end
      
      def filtr_select_field_desc(field)
        self[:filtr_select_fields].find{|desc| desc if desc[:filtr_field] == field}
      end
      
      def fields_desc(field)
        self[:fields_desc].find{|desc| desc if desc[:field] == field}
      end
      
      def paginate_name
        self[:paginate_param][:paginate_attributes][:param_name]
      end
      
    end
  
    def children_filtr_param
      children_module = self.ancestors
       
    end

  end
end