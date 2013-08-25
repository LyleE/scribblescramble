class User < ActiveRecord::Base
	authenticates_with_sorcery!
	has_many :scribbles, :dependent => :destroy

	validates :username, :uniqueness => {:message => " is already taken"}
	validates_length_of :username, :minimum => 3, :message => "must be at least 3 characters long"
	validates_length_of :password, :minimum => 6, :message => "must be at least 6 characters long", :if => :password
	validates_confirmation_of :password, :message => "doesn't match", :if => :password

	def won_vs other
		update_rating 1.0, other
	end

	def lost_vs other
		update_rating 0.0, other
	end

	private

	# http://en.wikipedia.org/wiki/Elo_rating_system#Mathematical_details
	def update_rating actualResult, otherRating
		expectedResult = (Q rating) / ( (Q rating) + (Q otherRating) )
		newRating = ( rating + 32.0*(actualResult - expectedResult) ).round
		update( rating: newRating )
	end

	def Q rating
		10.0 ** (rating.to_f / 400.0)
	end
end
