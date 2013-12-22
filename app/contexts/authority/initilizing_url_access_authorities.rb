class Authority::InitilizingUrlAccessAuthorities < Authority::BaseAuthorities
  
  def initialize user, controller
    super 
    extend UrlAccessAuthoritySystem 
    extend Presenter    
  end

  def init_url_access_authorities    
    in_context do
        update_url_access_authorities
        c.redirect_to v.root_path#v.admin_authority_url_access_authorities_path
    end
  end
  
  module UrlAccessAuthoritySystem
    
    def update_url_access_authorities
      url_access_authority.delete_all
      application_controller_action_methods = get_application_controller_actions
      routes = get_routes
      self.get_controllers.each do |controller|
        controller.action_methods.each do |action_method|
          if application_controller_action_methods.include?(action_method)
            break
          end
          route_path = get_route_path(routes, controller.controller_path, action_method)
          
          access_authorized_roles = "[0, 1, 10, 23]"          
          access_authorized_roles = "[0, 1]" if controller.controller_path.match 'admin'
          access_authorized_roles = "[0, 1]" if controller.controller_path.match 'tarifer'
          access_authorized_roles = "[0, 2]" if controller.controller_name == "url_access_authorities"
          access_authorized_roles = "[0, 3]" if controller.controller_name == 'user_authorities'
          access_authorized_roles = "(20..27)" if controller.controller_path.match 'home'
          access_authorized_roles = "(20..27)" if controller.controller_path.match 'home'          
          access_authorized_roles = "(20..27)" if route_path and route_path.match 'login'
          access_authorized_roles = "(20..27)" if route_path and route_path.match 'logout'

          if Admin::Authority::UrlAccessAuthority.where(:controller_path => controller.controller_path, :action => action_method).count == 0
            Admin::Authority::UrlAccessAuthority.create!(
              :controller_path => controller.controller_path,
              :route_path => get_route_path(routes, controller.controller_path, action_method),
              :controller => controller.controller_name,
              :action => action_method,
              :restricted => true,
              :access_authorized_roles => access_authorized_roles, 
              :condition => "",
              :method_to_call_before_condition => "",
              :processed => false
            )
          end  
        end
      end
    end

    def get_controllers
      Rails.application.eager_load! 
      controllers = []
      ApplicationController.descendants.each do |controller|
        controllers << controller
      end
      controllers
    end
    
    def get_application_controller_actions
      action_methods = ApplicationController.action_methods.each do |action_method|
        action_method
      end
    end
    
    def get_routes
  #Rails.application.routes.routes.last.constraints[:request_method]    
      routes= Rails.application.routes.routes.map do |route|
        {alias: route.name, route_path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action]}
      end    
    end
    
    def get_route_path(routes, controller_path, action)
      result = nil
      routes.each do |route|
        if route[:controller].to_s == controller_path.to_s and route[:action].to_s == action.to_s
          result = route[:route_path]
        end
      end  
      result
    end
      
  end    

  module Presenter

  end
  
end