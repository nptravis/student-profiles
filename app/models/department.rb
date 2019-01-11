class Department < ApplicationRecord
	belongs_to :school
	has_many :courses

	validates :school_id, :dcid, :name, presence: true
end
