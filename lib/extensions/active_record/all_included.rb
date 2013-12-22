require 'active_support/concern'

module AllIncluded
 extend ActiveSupport::Concern

  def foo
    'foo'
  end  

  module ClassMethods
    def with_all_belongs_included
      self.includes(list_of_belongs_to_key_fields)
    end 
  

    def list_of_belongs_to_key_fields
      fields=[]
      reflections.keys.each do |field|
        fields<<field if reflections[field].macro==:belongs_to# and column_names.include?(field)
      end 
    end 
  end
end

ActiveRecord::Base.send(:include, AllIncluded)