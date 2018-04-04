class StandardsController < ApplicationController
	def index
		@standards = Standard.all
	end

	def show
		@standard = Standard.find(params[:id])
	end
end