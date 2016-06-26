class SessionsController < ApplicationController

  def new

  end

  def create
    
    login = params[:session][:login].downcase
    assert_object_is_not_null (login)
    password = params[:session][:password]
    assert_object_is_not_null (password)
    user = User.find_by(login: login)
    assert_object_is_not_null (user)

    if (user && user.authenticate(password))
      sign_in user
    return redirect_to root_path
    
    else
      flash[:error] = "Login ou senha invalidos!"
      render :new
    end
  end

  def destroy
    
    if (signed_in?)
      sign_out 
    return redirect_to root_path
    end
  end

    else 
      # Nothing to do
    end 
end
