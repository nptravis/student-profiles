class CommentsController < ApplicationController
	before_action :authentication_required
	before_action :set_student, only: [:index, :show, :create]

	def index
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.student = @student
		@comment.user_id = current_user.id
		if @comment.save
			# redirect_to student_path(@student)
			render json: @comment, status: 201
		else
			render 'index'
		end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.user_id == current_user.id
			@comment.content = comment_params["content"]
			@comment.save
			redirect_to student_path(params[:student_id])
		else
			redirect_to student_path(params[:student_id])
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to student_path(params[:student_id])
	end

	def show
		@comment = Comment.find(params[:id])

	end

	private

	def set_student
		@student = Student.find(params[:student_id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end

end