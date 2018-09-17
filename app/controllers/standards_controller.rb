class StandardsController < ApplicationController

	def index
		@standards = Standard.all
	end

	def show
		@standard = Standard.find(params[:id])
		@terms = @standard.terms
		@grade_levels = @standard.sections.pluck(:grade_level).uniq
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

	private

	def standard_params
		params.require(:standard).permit(:id)
	end

end

