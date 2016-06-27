#  File: sessions
#  Purpose: Implementation of Sessions Controller
#  License : LGPL. No copyright.
# This controller create the login, password and user.

class SessionsController < ApplicationController

  def new

  end

# name: create
# explanation: this method searches for a user that matches the provided login information.
# parameters:
# - non
# return: redirect_to root_path

  def create
    
    login = params[:session][:login].downcase
    assert_object_is_not_null (login)
    password = params[:session][:password]
    assert_object_is_not_null (password)
    user = User.find_by(login: login)
    assert_object_is_not_null (user)

    # Verifies if the provided password is correct.
    if (user && user.authenticate(password))
      sign_in user
    return redirect_to root_path
    
    else
      flash[:error] = "Login ou senha invalidos!"
      render :new
    end
  end

# name: create
# explanation: this method finishes the user session.
# parameters:
# - non
# return: redirect_to root_path

  def destroy
    
    if (signed_in?)
      sign_out 
      return redirect_to root_path
    else 
      # Nothing to do
    end 
  end

end
