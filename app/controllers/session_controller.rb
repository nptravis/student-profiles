class SessionController < ApplicationController
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.find_by(username: user_params[:username])
  	if @user && @user.authenticate(user_params[:password])
  		session[:user_id] = @user.id
  		redirect_to user_path(@user)
  	else
  		flash[:message] = "Can not find and/or authenticate user"
  		redirect_to signup_path
  	end
  end

  def destroy
  	session.clear
  	redirect_to login_path
  end

  private

  def user_params
  	params.require(:user).permit(:username, :password)
  end
  
end
