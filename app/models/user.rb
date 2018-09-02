class User < ApplicationRecord
	has_many :comments
	has_many :students, through: :comments
	has_secure_password
	validates :username, length: { in: 6..20 }
	validates :password, length: { minimum: 8 }, allow_nil: true

	def self.find_or_create_by_omniauth(auth_hash)
		self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
			user.password = SecureRandom.hex
			user.username = auth_hash["info"]["name"]
			user.image_url = auth_hash["info"]["image"]
		end
	end

end
