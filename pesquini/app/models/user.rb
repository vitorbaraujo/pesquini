#  File: state
#  Purpose: Implementation of user model
#  License : LGPL. No copyright.

# This controller represents an user of the application.

class User < ActiveRecord::Base

# Validates login and password
	has_secure_password
	validates :login, length: { maximum: 50, minimum: 5 }, uniqueness: { case_sensitive: false }, allow_blank: false
	validates :password, length: { minimum: 8 }, allow_blank: false

# name: User.new_remember_token
# explanation: this method generates an unique random string for user.
# parameters:
# - non
# return: secure_token

	def User.new_remember_token
  	secure_token = SecureRandom.urlsafe_base64
  	return secure_token
  end

# name: User.digest
# explanation: this method encrypts the parameter received.
# parameters:
# - non
# return: encripted_token

  def User.digest(token)
  	encripted_token = Digest::SHA1.hexdigest( token.to_s )
  	return encripted_token
 	end
end
