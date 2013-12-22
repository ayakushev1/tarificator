module ArrayAndString
  extend ActiveSupport::Concern

  def as_array(field_name_as_symol)
    string_to_array(self[field_name_as_symol])
  end

  def string_to_array(string)
    string = "[]" unless string
    result = eval(string)
    if result.class == Range
      result = result.to_a
    else
      unless (result.class == Array) and array_elements_are_integer?(result)
        raise Exception, "Wrong authoritazion string #{string} in #{self}"  unless result and (result.class == Array)
      end
    end
    result
  end  
  
  def array_elements_are_integer?(arr)
    result = true
    arr.each do |a|
      unless a.class == Fixnum
        result = false
        break
      end
    end
    result  
  end
  
end