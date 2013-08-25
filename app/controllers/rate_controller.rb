class RateController < ApplicationController

	def index
		@type = ScribbleType.random_rateable
		if(@type)
			@scribbles = Scribble.where(scribble_type_id: @type.id).where("last_rated < ?", Time.now.to_i - 60).limit(2)

			if(@scribbles.count == 2)
				return
			end
		end
		
		redirect_to :play, :notice => 'No ratings available'
	end

end