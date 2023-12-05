# email: string
# password_digest: string
#
# password: string virtual
# passowrd_confimation: string virtual
#
class User < ApplicationRecord
	has_secure_password

	validates :email, presence: true, format: {with:/\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address" }
end
