class StandardTerm < ApplicationRecord
	belongs_to :term
	belongs_to :standard

	validates :term_id, :standard_id, presence: true
end