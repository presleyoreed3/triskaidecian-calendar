class ApplicationController < ActionController::Base

	before_action :set_current_user, if: :logged_in?
	# skip_before_action :set_current_user, only: [:new, :create]

	def set_current_user
		if session[:user_id]
			Current.user = User.find_by(id: session[:user_id])
		end
	end

	def require_user_logged_in!
		redirect_to sign_in_path, alert: "You must be signed in to do that" if Current.user.nil?
	end

	def current_user
  	Current.user ||= User.find(session[:user_id])
	end

	def logged_in?
		current_user
	end

end
