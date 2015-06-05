class SessionsController < ApplicationController
	def new
	end
	def create
		user = User.find_by(login: params[:session][:login].downcase)
  		if user && user.authenticate(params[:session][:password])
  			sign_in user
  			redirect_to root_path
  		else
			  flash[:error] = 'Invalid combination.'
			  render 'new'
  		end	
	end
  def destroy
    if signed_in?
      sign_out 
      redirect_to root_path
    end
  end
 end
