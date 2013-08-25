class DrawController < ApplicationController

	def index
		# Get a random scribble type!
		@type = ScribbleType.random
	end

	def save
		image = Base64.decode64(params[:data]);
		type = ScribbleType.find(params[:type_id])

		key = getKey type

		s = Scribble.new(s3_key: key, scribble_type_id: type.id, user_id: current_user.id)
		s.saveImage image

		redirect_to :play
	end

	private

	def getKey type
		type.name.tr(' ','_')+"_"+(1000.0*Time.now.to_f).to_i.to_s+".png"
	end

end