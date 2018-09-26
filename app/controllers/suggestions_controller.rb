class SuggestionsController < ApplicationController

	def index
		@suggestions = Suggestion.all
	end

	def new
		@suggestion = Suggestion.new
	end

	def create
		@suggestion = Suggestion.new(suggestion_params)
		@suggestion.user = current_user
		if @suggestion.save
			redirect_to suggestions_path
		else
			redirect_to new_suggestion_path
		end
	end

	def destroy
	end

	def show
		@suggestion = Suggestion.find(params[:id])
		render json: @suggestion, serializer: suggestionSerializer 
	end

	private

	def suggestion_params
		params.require(:suggestion).permit(:content)
	end

end
