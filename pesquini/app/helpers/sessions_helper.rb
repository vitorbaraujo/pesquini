# File: sessions_helper.rb
# Purpose: File that implements additional logic for users in the application,
# such as logging in and out.
# License : LGPL. No copyright

module SessionsHelper

  # name: sign_in
  # explanation: Permits a user to enter within the application
  # parameters:
  #- user: A object from the User class
  # return: User
  def sign_in user
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

  # name: current_user=
  # explanation: This sets the variable @current_user to the user that is passed
  # as argument
  # parameters:
  #- user: A object from the User class
  # return: User set to the variable
  def current_user=(user)
    	@current_user = user
  end

  # name: current_user
  # explanation: This sets the variable @current_user to the user that is
  # currently logged in the system
  # parameters:
  #- none
  # return: User using the application
  def current_user
	  remember_token = User.digest(cookies[:remember_token])
	  @current_user ||= User.find_by(remember_token: remember_token)
  end

  # name: signed_in?
  # explanation: This method checks is there is anyone logged in the system
  # parameters:
  #- none
  # return: True if there is anyone logged and false if there is no one
  def signed_in?
    !current_user.nil?
  end

  # name: authorize
  # explanation: This method takes the application back to the sign in page
  # if there isn't anyone logged in for security
  # parameters:
  #- none
  # return: Redirected to sign in page or nothing if there is a logged user
  def authorize
    redirect_to '/signin', alert: "Nao autorizado !" unless signed_in?
  end

  # name: sign_out
  # explanation: This method lets user leave the application
  # parameters:
  #- none
  # return: current_user set to nil, meaning no one is logged in
  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
