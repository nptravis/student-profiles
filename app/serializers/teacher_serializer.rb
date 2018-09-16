class TeacherSerializer < ApplicationSerializer
	attributes :email, :id, :lastfirst, :show
	attributes :current_sections
	# attributes :email, if: :current_user - this line needs Devise to use, for only displaying attributes if user is current_user
	has_many :sections
	has_many :students, through: :sections

	def show
		TeachersController.render(:show, assigns: {teacher: object}, layout: false)
	end

	def current_sections
		TeachersController.render(:current_sections, assigns: {teacher: object}, layout: false).squish
	end


end