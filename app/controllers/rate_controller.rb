class RateController < ApplicationController

	def index
		@type = ScribbleType.random_rateable
		if(@type)
			now = Time.now.to_i
			@scribbles = Scribble.
				#where("last_rated < ?", now - 60).
				where(scribble_type_id: @type.id).
				group(:user_id).
				where.not(user_id: current_user.id).
				limit(2)

			if(@scribbles.length == 2)
				@scribbles.each do |s|
					s.update(last_rated: now)
				end
				return
			end
		end
		
		redirect_to :play, :notice => 'No ratings available'
	end

	def save
		winningScribble = Scribble.where(s3_key: params[:winner]).first
		losingScribble = Scribble.where(s3_key: params[:loser]).first
		if winningScribble and losingScribble
			winner = winningScribble.user
			loser = losingScribble.user

			winnerOldRating = winner.rating
			loserOldRating = loser.rating

			winner.won_vs(loserOldRating)
			loser.lost_vs(winnerOldRating)

			winningScribble.destroy
			losingScribble.destroy
		end

		redirect_to :rate
	end

end