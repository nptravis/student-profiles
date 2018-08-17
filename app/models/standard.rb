class Standard < ActiveRecord::Base
	has_many :grades
	has_many :students, through: :grades
	has_many :courses, through: :grades
	validates :dcid, :standardname, :identifier, presence: true

	def hom?
		!!self.standardname.match(/\bRespect\b|\bResponsibility\b|\bEngagement\b|\bReflection\b/)
	end

end

