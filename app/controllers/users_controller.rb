class UsersController < ApplicationController

	def new
		@user = User.new
	end


	def show
		if logged_in?
			@current_user = current_user
			@students = Student.all.sort_by &:lastfirst
		else
			redirect_to login_path
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save && user_params[:password] == user_params[:password_confirmation]
			login(@user)
			redirect_to user_path(@user)
		else
			redirect_to new_user_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end

end
