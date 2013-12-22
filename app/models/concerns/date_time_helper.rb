module DateTimeHelper
  
  def check_if_date_in_range(date_to_compare, start_date, end_date)
    start_date = check_if_string_and_parse_to_date(start_date)
    end_date = check_if_string_and_parse_to_date(end_date)
    
    return false unless date_to_compare >= start_date
    return false unless date_to_compare <= end_date
    true
  end
  
  def make_datetime_from_two_datetimes(date_part, time_part)
    Time.mktime(date_part.year, date_part.month, date_part.day, time_part.hour, time_part.min, time_part.sec)
  end
  
  def sec_to_date(secunds)
    DateTime.strptime(secunds.to_f.round.to_s,'%s')
  end
  
  def check_if_string_and_parse_to_date(date_to_check)
    ( Date.parse(date_to_check) if date_to_check.respond_to?(:to_str) ) || date_to_check
  end  
  
  
  def minimum_date_from_array_of_hashes(arr, field)
    minimun_value = Time.mktime(2020, 1, 1, 1, 1, 1) || (Time.now + 10000.days)
    arr.each do |element| 
      minimun_value = element[:start] if (element[:start] and element[:start] < minimun_value)     
    end    
#    minimum_value 
  end
  
  def minimum_of_two_dates(date_1, date_2)
    date_1 = check_if_string_and_parse_to_date(date_1)
    date_2 = check_if_string_and_parse_to_date(date_2)
    if date_1 and date_2
      if date_1 > date_2
        date_2
      else
        date_1
      end
    else
      return date_2 if date_1      
      return date_1 if date_2      
    end      
  end
  
  def maximum_of_two_dates(date_1, date_2)
    date_1 = check_if_string_and_parse_to_date(date_1)
    date_2 = check_if_string_and_parse_to_date(date_2)
    if date_1 and date_2
      if date_1 < date_2
        date_2
      else
        date_1
      end
    else
      return date_2 if date_1      
      return date_1 if date_2      
    end      
  end
  
end