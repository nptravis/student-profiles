class User < ApplicationRecord
	has_secure_password
	validates :username, presence: true

	def self.find_or_create_by_omniauth(auth_hash)
		self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
			user.password = SecureRandom.hex
			user.username = auth_hash["info"]["name"]
		end
	end
end
