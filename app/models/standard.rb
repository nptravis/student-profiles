class Standard < ActiveRecord::Base
	has_many :grades
	has_many :course_standards
	has_many :standards, through: :course_standards
	validates :standard_name, :identifier, :dcid, presence: true

	def hom?
		!!self.standard_name.match(/\bRespect\b|\bResponsibility\b|\bEngagement\b|\bReflection\b/)
	end

end

