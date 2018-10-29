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

	def update
		@suggestion = Suggestion.find(params[:id])
		if @suggestion.user_id == current_user.id
			@suggestion.content = suggestion_params[:content]
			@suggestion.save
			redirect_to suggestions_path
		else
			redirect_to suggestions_path
		end
	end

	def destroy
		@suggestion = Suggestion.find(params[:id])
		@suggestion.destroy
		respond_to do |format|
			format.html {redirect_to suggestions_path}
			format.js {render text: "suggestion destroyed"}
		end
	end

	def show
		if params[:user_id]
			@suggestion = Suggestion.find(params[:id])
		else
			@suggestion = Suggestion.find(params[:id])
			render json: @suggestion, serializer: suggestionSerializer 
		end
	end

	private

	def suggestion_params
		params.require(:suggestion).permit(:content)
	end

end
