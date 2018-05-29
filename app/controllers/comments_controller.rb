class CommentsController < ApplicationController
	before_action :set_student, only: [:index, :create]

	def index
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.student = @student
		@comment.user = current_user

		if @comment.save
			redirect_to student_comments_path(@student)
		else
			render 'index'
		end
	end

	private

	def set_student
		@student = Student.find(params[:student_id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end

end