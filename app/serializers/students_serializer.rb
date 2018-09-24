class StudentsSerializer < ApplicationSerializer
  attributes :index

  def index
  	StudentsController.render(:index, layout: false)
  end
end
