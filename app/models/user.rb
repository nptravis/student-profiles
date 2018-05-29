class User < ApplicationRecord
	has_many :comments
	has_many :students, through: :comments
	has_secure_password
	validates :username, length: {in: 6..20}
	validates :password, length: {in: 6..20}
	validates :password, confirmation: { case_sensitive: true }

	def self.find_or_create_by_omniauth(auth_hash)
		self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
			user.password = SecureRandom.hex
			user.username = auth_hash["info"]["name"]
		end
	end
end
