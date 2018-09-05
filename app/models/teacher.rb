class Teacher < ApplicationRecord
	has_many :sections
	has_many :students, through: :sections
	has_many :grades, through: :sections
	has_many :courses, through: :sections
	validates :email, :lastfirst, :dcid, :teacher_number, presence: true

	def self.teacher?(user)
		!!Teacher.find_by(email: user.email)
	end

end
