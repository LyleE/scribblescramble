class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	before_filter :require_login, :check_notifications

  	protected
	def not_authenticated
  		redirect_to login_path, :alert => "Please login first."
	end

	private

	def check_notifications
		if logged_in?
			if not current_user.happy_notifications.empty?
				flash_append :notice, current_user.happy_notifications
				current_user.update(happy_notifications: "")
			end
			if not current_user.sad_notifications.empty?
				flash_append :alert, current_user.sad_notifications
				current_user.update(sad_notifications: "")
			end
		end
	end

	def flash_append label, msg
		if flash.now[label].nil?
			flash.now[label] = ""
		else
			flash.now[label] += "\n"
		end
		flash.now[label] += msg
		flash.now[label] = flash.now[label].gsub("\n", "<br />").html_safe
	end
end
