class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_data, :if_logged_in?, :is_admin?

	# Return the current logged-in user (if any)
	def current_user_data
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Return true if the user is logged in, false otherwise.
	def if_logged_in?
		!current_user.nil?
	end

	def is_admin?
		@current_user.admin?
	end


	
end 
