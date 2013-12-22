class SessionsController < ApplicationController
  def new
    @login = Filtrs::Filtr.new(self, "login")
  end

  def create
    @login = params[:login_filtr]
    if @login 
      user =User.find_by_name(@login[:name])
      if user and user.authenticate(@login[:password])
        session[:user_id]=user.id
        redirect_to(session[:previous_url] || user_path(user)) 
      else
        redirect_to login_path, alert: "Invalid user/password combination"  
      end
    else
      redirect_to login_path, alert: "there is no :login_filtr in params"
    end
  end
    
  def destroy
    session.destroy
    redirect_to root_path
  end
end
