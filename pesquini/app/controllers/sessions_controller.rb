class SessionsController < ApplicationController

  def new

  end

  def create
    login = params[:session][:login].downcase
    password = params[:session][:password]
    user = User.find_by(login: login)

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
