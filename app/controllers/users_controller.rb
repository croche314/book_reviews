class UsersController < ApplicationController
	#get '/'
	def log_reg
		if session[:user_alias]
			redirect_to '/books'
		else
			render 'log_reg'
		end
	end
	def new_user
		#@user = User.new(name:params[name],alias:params[alias],email:params[email],password:params[password],)
		@user = User.new(user_params)
		if @user.valid?
			@user.save
			redirect_to '/books'
		else
			flash[:warning] = 'Passwords do not match!'
			redirect_to '/'
		end
	end

	def login
		@result = User.where("email = ?", params[:email])
		@user = @result[0]
		if @result.length < 1
			flash[:warning] = 'email not found!'
			redirect_to '/'
		else
			if @user.authenticate(params[:password])
				session[:user_alias] = @user.alias
				redirect_to '/books'
			else	
				flash[:warning] = 'password invalid!'
				redirect_to '/'
			end
		end
	end

	private
		def user_params
			params.require(:user).permit(:name,:alias,:email,:password,:password_confirmation)	
		end
end
