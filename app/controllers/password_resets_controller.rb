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

	def edit 
		@user = User.find_signed(params[:token], purpose: "password_reset")
	rescue ActiveSupport::MessageVerifier::InvalidSignature
		redirect_to sign_in_path, alert: "Your link has expired. Please try again."
	end

	def update
		@user = User.find_signed(params[:token], purpose: "password_reset")
		if @user.update(password_params)
			redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."
		else
			render :edit
		end
	end

	private

	def password_params
		params.require(:user).permit(:password, :password_confimation)
	end

end