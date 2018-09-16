class SuggestionSerializer < ApplicationSerializer
	attributes :content, :show
	# belongs_to :user

	def show
		SuggestionsController.render(:show, assigns: {suggestion: object}, layout: false).squish
	end

end