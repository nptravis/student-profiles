class SessionController < ApplicationController
  
  def index
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
  
  def new
  	@user = User.new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      @user = User.find_or_create_by_omniauth(auth_hash)
      login(@user)
      redirect_to user_path(@user)
    else
    	@user = User.find_by(username: user_params[:username])
    	if @user && @user.authenticate(user_params[:password])
    		login(@user)
    		redirect_to user_path(@user)
    	else
    		flash[:message] = "Can not find and/or authenticate user"
    		redirect_to signup_path
    	end
    end
  end

  def destroy
  	session.clear
  end

  private

  def user_params
  	params.require(:user).permit(:username, :password)
  end
  
end
