class RateController < ApplicationController

	def index
		@type = ScribbleType.random_rateable
		if(@type)
			now = Time.now.to_i
			@scribbles = Scribble.
				where("last_rated < ?", now - 60). #delay to give people 60 seconds to rate before serving again
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

		if flash[:draw_redirect]
			redirect_to :play
		else
			redirect_to :play, :alert => "No more ratings for now. Come back later!"
		end
	end

	def save
		winningScribble = Scribble.where(s3_key: params[:winner]).first
		losingScribble = Scribble.where(s3_key: params[:loser]).first
		if winningScribble and losingScribble
			winner = winningScribble.user
			loser = losingScribble.user

			winnerOldRating = winner.rating
			loserOldRating = loser.rating

			pointsWon = winner.won_vs(loserOldRating)
			winner.happy_note "Your scribble of #{winningScribble.scribble_type.full_name} earned you #{pointsWon} points :)"

			pointsLost = loser.lost_vs(winnerOldRating)
			loser.sad_note "Your scribble of #{losingScribble.scribble_type.full_name} lost you #{-pointsLost} points :("

			winningScribble.destroy
			losingScribble.destroy
		end

		redirect_to :rate, :flash => { draw_redirect: true, notice: "Thanks! Want to rate another?" }
	end

end