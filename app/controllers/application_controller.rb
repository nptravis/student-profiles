class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def authentication_required
    if !logged_in?
      flash[:message] = "Must be logged in to do anything"
      redirect_to login_path
    end
  end

  def admin_auth_required
    if !@current_user.admin
     puts "ADMIN!!!!!!!!!!!!!!!!"
      flash[:message] = "Must be admin in to do that"
      redirect_to user_path(@current_user)
    end
  end

  def login(user)
  	session[:user_id] = user.id
  end

  def logged_in?
  	!!current_user
  end

  def current_user
  	@current_user ||= User.find_by(:id => session[:user_id])
  end

  helper_method :current_user
end
