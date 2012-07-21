class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @title = 'create'
   		user = User.find_by_email(params[:session][:email])
 		if user && user.authenticate(params[:session][:password])
			
      redirect_to user
    else
       flash.now[:error] = 'Invalid Email/Password Combination!'
       render 'new'
		end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
