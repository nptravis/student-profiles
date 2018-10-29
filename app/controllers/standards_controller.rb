class StandardsController < ApplicationController

	def index
		if params[:standard]
			@standards = Standard.search(standard_params[:search])
		else
			@standards = Standard.order(:identifier)
		end
	end

	def show
		@standard = Standard.find(params[:id])
		hasher = CollectionService.new
		@terms = @standard.terms
		@grades_hash = hasher.create_grades_hash(@standard.grades)
		@grade_levels = @standard.students.pluck(:grade_level).uniq.sort
	end

	def grades_per_term 
		@standard = Standard.find(params[:id])
		term = Term.find(params[:term][:term_code])
		grades = @standard.grades.where("term_id = ?", term.id)
		render json: grades.to_json
	end

	def all_grades
		@standard = Standard.find(params[:id])
		render json: @standard, serializer: StandardSerializer
	end

	def filtered_grades
		@standard = Standard.find(params[:id])
		grades = @standard.grades_per_term_per_grade_level(params[:termId], params[:gradeLevels])
		render json: grades.to_json(only: :grade)
	end

	private

	def standard_params
		params.require(:standard).permit(:id, :search)
	end

end

