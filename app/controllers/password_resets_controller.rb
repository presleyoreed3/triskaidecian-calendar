class PasswordResetsController < ApplicationController
	def new

	end

	def create
		@user = User.find_by(email: params[:email])
		if @user.present?
			PasswordMailer.with(user: @user).reset.deliver_later
		end
		redirect_to root_path, notice: "If we find you in our database you will receive and email from us shortly."
	end
end