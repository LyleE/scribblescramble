class DrawController < ApplicationController

	def index
		@target = "a duck"
	end

	def save
		File.open("testing.png","wb") do |f|
			f.write(Base64.decode64(params[:data]));
		end
		redirect_to :root
	end

end