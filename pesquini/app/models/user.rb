class User < ActiveRecord::Base
	include Assertions
	extend Assertions

	has_secure_password
	validates :login, length: { maximum: 50, minimum: 5 },
	uniqueness: { case_sensitive: false },
	allow_blank: false
	validates :password,
	length: { minimum: 8 },
	allow_blank: false

  def User.new_remember_token
  	secure_token = SecureRandom.urlsafe_base64
	return secure_token
  end


  def User.digest(token)
  	encripted_token = Digest::SHA1.hexdigest( token.to_s )
  	return encripted_token
  end

end
 
