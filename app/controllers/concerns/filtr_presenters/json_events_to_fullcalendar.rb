module FiltrPresenters
  
  module JsonEventsToFullcalendar
    
    def json_events_to_fullcalendar
      show_start_date = c.params[:start] || Time.now
      show_end_date = c.params[:end] || (Time.now + 70.days)
      model = @model_raws_to_show
      
      events = calculate_events(model, show_start_date, show_end_date)
      
      if model.exists? 
        if model.first.schedule.periodicity_type_id == 2
          show_start_date = model.first.schedule.start_of_schedule
        else
          show_start_date = maximum_of_two_dates(model.minimum(:on_schedule_date) || (Time.now), Time.now)
        end 
      end
      
      if c.params[:move_to_selected_date] == "false"
        show_start_date = c.params["current_date_1"]
      else
        show_start_date = c.params[:current_calendar_date] if c.params[:current_calendar_date]
      end
      
      {:events => events,
       :start_date => show_start_date, #Time.zone.parse(show_start_date),
       :url_new => p.fields_desc(:url_new)[:field_name_formula][:url],
      }      
    end
    
    def calculate_events(model, show_start_date, show_end_date)
      events = []
      model.each do |model_raw|      
        base_event = set_standard_fields_of_fullcalendar_event(model_raw)
    
        if model_raw.schedule.periodicity_type_id == 2 # periodic
          show_start_date_1, show_end_date_1 = start_and_end_dates_for_periodic_calculation(model_raw, show_start_date, show_end_date)              
          calculation_of_fake_events_for_periodic(events, base_event, model_raw, show_start_date_1, show_end_date_1)
        else
          events.push( base_event.merge( calculate_on_schedule_additional_fields(model_raw) ) )
        end          
      end
      events      
    end
    
    def start_and_end_dates_for_periodic_calculation(model_raw, show_start_date, show_end_date)
      show_start_date = maximum_of_two_dates(show_start_date, model_raw.schedule.start_of_schedule)
      show_end_date = minimum_of_two_dates(show_end_date, model_raw.schedule.end_of_schedule)

      if (model_raw.periodic_week_day_id - show_start_date.cwday) >= 0  
        show_start_date = show_start_date + (model_raw.periodic_week_day_id - show_start_date.cwday).days
      else
        show_start_date = show_start_date + (model_raw.periodic_week_day_id - show_start_date.cwday).days + 7
      end
                    
      if (model_raw.periodic_week_day_id - show_end_date.cwday) > 0  
        show_end_date = show_end_date + (model_raw.periodic_week_day_id - show_end_date.cwday).days - 7
      else
        show_end_date = show_end_date + (model_raw.periodic_week_day_id - show_end_date.cwday).days 
      end
      [show_start_date, show_end_date]
    end
    
    def number_of_calculation_weeks(show_end_date, show_start_date)
      ((show_end_date - show_start_date)/7).to_int + 1
    end
    
    def calculation_of_fake_events_for_periodic(events, base_event, model_raw, show_start_date, show_end_date)
      number_of_calculation_weeks(show_end_date, show_start_date).times do |week|
        current_date = show_start_date + (week*7).days
        events.push(base_event.merge( calculate_periodic_additional_fields(model_raw, current_date) ) )
      end              
      events
    end
    
    def calculate_periodic_additional_fields(model_raw, current_date)
      {:real_id => model_raw.id,
      :start => make_datetime_from_two_datetimes(current_date, model_raw.time_start).rfc822,
      :end => make_datetime_from_two_datetimes(current_date, model_raw.time_end).rfc822,
      :periodicity_type_id => 2,
      :schedule_start_date => model_raw.schedule.start_of_schedule,
      }
    end
    
    def calculate_on_schedule_additional_fields(model_raw)
      {:id => model_raw.id,
       :start => make_datetime_from_two_datetimes(model_raw.on_schedule_date, model_raw.time_start).rfc822,
       :end => make_datetime_from_two_datetimes(model_raw.on_schedule_date, model_raw.time_end).rfc822,
       :periodicity_type_id => 3 } 
    end
    
    def set_standard_fields_of_fullcalendar_event(raw)
      standard_fields = {}
      
      p[:fields_desc].each do |field|
        case field[:field_type]
        when :url_hash
          standard_fields[field[:field]] = {}
          standard_fields[field[:field]][:url] = insert_string_instead_template(field[:field_name_formula][:url], /:id/, raw.id)
          standard_fields[field[:field]][:method] = field[:field_name_formula][:method]
          standard_fields[field[:field]][:data] = field[:field_name_formula][:data]
        else
          standard_fields[field[:field]] =eval(field[:field_name_formula])
        end
      end
      standard_fields
    end
    
    def insert_string_instead_template(string_to_change, pattern, replacement)
      if string_to_change
        string_to_change.sub(pattern, replacement.to_s)
      else
        "#"
      end
    end

  end

end