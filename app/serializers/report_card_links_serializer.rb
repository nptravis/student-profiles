class ReportCardLinksSerializer < ApplicationSerializer
  attributes :id, :links

  def links
  	StudentsController.render(:_report_card_links, assigns: {student: object}, layout: false).squish
  end
end
