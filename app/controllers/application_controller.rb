class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Filtrs
  
#  uncomment to turn off caching
#  before_action :set_cache_buster
#  filter_parameter_logging :password
  protect_from_forgery with: :exception
  before_action :store_previous_url
  before_action :authorize#, :except => [:login, :logout, :home]
  before_action :run_context
  
  attr_reader :current_user, :current_user_roles
  
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
   
  def store_previous_url
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/.*?[login]/
  end
  
  def getBinding
    return binding
  end

  protected
  def authorize
    session[:user_id] ? @current_user=User.find(session[:user_id]) : set_current_user_for_guest  

    Authority::CheckingUrlAccessAuthorities.new(@current_user, self).check_url_access_authorities
  end

  def set_current_user_for_guest
    @current_user = User.find(0)
  end
    
  def check_user_login
    redirect_to login_url, notice => @current_user.name unless session[:user_id]#'Please login before working with Games'
  end

  def run_context
    if respond_to?(:context_class) and context_class.method_defined?(action_name)
      context_class.new(current_user, self).send(action_name)
    end
  end
  
end
  
