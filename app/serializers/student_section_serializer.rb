class StudentSectionSerializer < ApplicationSerializer
  attributes :id, :section_show

  def section_show
  	StudentsController.render(:_section_show, assigns: {section: object}, layout: false).squish
  end

end
