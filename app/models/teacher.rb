class Teacher < ApplicationRecord
	has_many :sections
	has_many :students, through: :sections
	has_many :grades, through: :sections
	has_many :courses, through: :sections
	validates :email, :name, presence: true

end
