message_on_mouse_over_day = (element)->
  $(element).addClass("success") 
  $(element).attr("title", "") 
  $(element).tooltip( 
    content: "press to add new event"
  )   

message_on_mouse_out_day = (element) ->
  $(element).removeClass("success") 
  unless $.isEmptyObject($(element).attr("aria-describedby"))
    $(element).attr("title", null) 
    $(element).tooltip("destroy") 

message_on_mouse_over_event = (event, jsEvent, view) ->
  $(this).attr("title", "") 
  $(this).tooltip(
    content: "press to edit event"
    )   

message_on_mouse_out_event = (event, jsEvent, view) ->
  unless $.isEmptyObject($(this).attr("aria-describedby"))
    $(this).attr("title", null) 
    $(this).tooltip("destroy") 

params_from_ajax = 
  selected_date: new Date()
  current_date_1: new Date()

change_view = (pressed_button) ->
  calendar = $(pressed_button).parents("[type=fullcalendar]")
  pressed_button_classes = $(pressed_button).attr("class").split(" ")
  if $.inArray('fc-button-month', pressed_button_classes) > -1
    initial_setup_values["header"]["center"] = 'agendaWeek title agendaDay' 
    initial_setup_values["aspectRatio"] = 5
    initial_setup_values["defaultView"] = "month" 
  if $.inArray('fc-button-agendaWeek', pressed_button_classes) > -1
    initial_setup_values["header"]["center"] = 'month title agendaDay' 
    initial_setup_values["aspectRatio"] = 2
    initial_setup_values["defaultView"] = "agendaWeek" 
  if $.inArray('fc-button-agendaDay', pressed_button_classes) > -1
    initial_setup_values["header"]["center"] = 'month title agendaWeek' 
    initial_setup_values["aspectRatio"] = 2
    initial_setup_values["defaultView"] = "agendaDay" 
  $(calendar).fullCalendar("destroy")  
  initial_setup_values["calendar"] = calendar
  $(calendar).fullCalendar(initial_setup_values)  
  $(calendar).fullCalendar 'addEventSource', get_events
  if initial_setup_values["move_to_selected_date"]
    $(initial_setup_values["calendar"]).fullCalendar('gotoDate', params_from_ajax["selected_date"])
  else
    $(initial_setup_values["calendar"]).fullCalendar('gotoDate', params_from_ajax["current_date_1"])

new_event = ( date, allDay, jsEvent, view ) ->
  if initial_setup_values["url_new"]
    jsEvent.preventDefault()
    Turbolinks.visit initial_setup_values["url_new"]
  
show_event = (event, jsEvent, view ) ->
  jsEvent.preventDefault()
  Turbolinks.visit event["url_show"]["url"]
  
safe_date = (date, d) ->
  t = new Date()
  if date.isDate# == "Date"
    if isNaN(date.getTime)
      new Date(t.getFullYear(), t.getMonth(), t.getDay() + d)
    else
      date
  else
    new Date(t.getFullYear(), t.getMonth(), t.getDay() + d)
  
get_events = (start, end, callback) ->
  if $.isEmptyObject(initial_setup_values["calendar"])# or $.isEmptyObject(current_calendar_date)
    current_calendar_date = safe_date($(initial_setup_values["calendar"]).fullCalendar("getDate"), 0)
  
  start1 = safe_date(start, -30)
  end1 = safe_date(end, +30)

  $.ajax 
    url: initial_setup_values["event_source_url"]
    type: 'get'
    data: 
      start: start1
      end: end1
      current_calendar_date: current_calendar_date
      current_date_1: params_from_ajax["current_date_1"]
      move_to_selected_date: initial_setup_values["move_to_selected_date"]
    dataType: "json"#"script" 
    global: false
    success: (data, textStatus, jqXHR) ->
      callback(data["events"])     
      initial_setup_values["url_new"] = data["url_new"]
      params_from_ajax["selected_date"] = new Date(data["start_date"])
      params_from_ajax["current_date_1"] = $(initial_setup_values["calendar"]).fullCalendar("getDate") if $.isEmptyObject(initial_setup_values["calendar"])
      if initial_setup_values["move_to_selected_date"]
        $(initial_setup_values["calendar"]).fullCalendar('gotoDate', params_from_ajax["selected_date"])
    
initial_setup_values = 
  defaultView: "month"
  editable: true
  header: 
    left: 'prevYear nextYear'
    center: 'agendaWeek title agendaDay'
    right: 'prev next'  
  aspectRatio: 5
  titleFormat:
    month: 'MMMM yyyy'
    week: "MMMM yyyy"
    day: 'MMMM dd, yyyy'    
  columnFormat:
    month: 'ddd'
    week: 'ddd  dd'
    day: 'dddd'    
  theme: false
  allDaySlot: false
  firstDay: 1
  firstHour: 9
  minTime: 5
  maxTime:24
  exisFormat: 'h(:mm)tt'
  lazyFetching: true
  move_to_selected_date: true
  dayClick: new_event
  eventClick: show_event
  eventMouseover: message_on_mouse_over_event
  eventMouseout: message_on_mouse_out_event

load_fullcalendars = (calendar)->
  $("[type=fullcalendar]").each (index, element) -> 
    load_one_fullcalendar(element)

load_one_fullcalendar = (calendar)->
    initial_setup_values["calendar"] = calendar
    initial_setup_values["move_to_selected_date"] = true
    initial_setup_values["event_source_url"] = $(calendar).attr("event_source_url")
    if $(calendar).not(".fc").size() > 0
      $(calendar).fullCalendar(initial_setup_values)
    $(calendar).fullCalendar 'addEventSource', get_events

$(document).on 'ready page:load ajaxComplete', -> 
  load_fullcalendars()
  
#  $(document).one 'show', (e)->
#    $($(e.target).attr("href")).find("[type=fullcalendar]").each (index, calendar) ->
#       $(calendar).find("[class*=fc-content]").each (index, element) ->
#         if $(element).val() == ""
#           load_one_fullcalendar(calendar)
  
  $(document).on 'click', '.fc-button-month,.fc-button-agendaWeek,.fc-button-agendaDay', ->
    change_view(this)    
    
  $(document).on 'click', '.fc-button-next, .fc-button-prev, .fc-button-nextYear, .fc-button-prevYear', ->
    initial_setup_values["move_to_selected_date"] = false
    
  $(document).on 'mouseover', '.fc-day', ->
     message_on_mouse_over_day(this)    

  $(document).on 'mouseout', '.fc-day', ->
     message_on_mouse_out_day(this)    
