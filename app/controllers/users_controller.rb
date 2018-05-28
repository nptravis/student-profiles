class UsersController < ApplicationController
	before_action :authentication_required, only: [:index, :show]
	
	def new
		@user = User.new
		@student = Student.new
	end


	def show
		@students = Student.all.sort_by &:lastfirst
	end

	def index
	end

	def create
		@user = User.new(user_params)
		if @user.save && user_params[:password] == user_params[:password_confirmation]
			login(@user)
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end

end
