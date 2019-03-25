class SessionsController < ApplicationController
	before_action :logged_in_restrict, only: [:new,:create]
	def new
		
	end
	
	def create
		user = User.find_by(username:params[:session][:username]) #Thi idenfies the user in the session
		if user && user.authenticate(params[:session][:password]) #Verify whether correct or not
			session[:user_id] = user.id
			flash[:success] = 'You have successfully logged in'
			redirect_to root_path
		else
			flash.now[:error] = 'There was something wrong with your information' #Only display ones the error message
			render 'new'
		end
	end
	
	def destroy
		session[:user_id]=nil
		flash[:success] = 'You have logged out'
		redirect_to login_path

	end
	private
		def logged_in_restrict
			if logged_in?
				flash[:error]= "You are already logged in"
				redirect_to root_path
			end 
		end

end