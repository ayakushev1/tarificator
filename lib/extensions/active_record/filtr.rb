module Filtr
  extend ActiveSupport::Concern
  
  module ClassMethods
    def make_filtr(filtr_values={})
      a=where("true")
      filtr_values.each { |key, value| a=a.where(key=>value) unless value.blank? }
      a
    end 
    
    def make_field_values(field, fltr_values)
      a=where("true")
      fltr_values.each { |key, value| a=a.where(key=>value) unless value.blank? }
      a.uniq.pluck(table_name+"."+field.to_s)
    end
    
    def make_filtr_select_options(filtr_select_fields, filtr_id_field, field_ids)    
      select(filtr_select_fields).where(filtr_id_field  => field_ids)
    end

    def check_filtr_for_model_fields(filtr_to_check)# filtr_to_check.key is symbol
      columns = []
      a={}
      column_names.each { |column| columns << column.to_sym} #string
      
      valid_filtr = {}
      filtr_to_check.each do |field, value|
        if columns.index(field.to_sym)
          valid_filtr[field.to_sym] = value
        end
      end
      valid_filtr
    end
  end
  
  
  
end

ActiveRecord::Base.send(:include, Filtr)