class User < ActiveRecord::Base
	authenticates_with_sorcery!
	has_many :scribbles

	validates :username, :uniqueness => {:message => " is already taken"}
	validates_length_of :username, :minimum => 3, :message => "must be at least 3 characters long"
	validates_length_of :password, :minimum => 6, :message => "must be at least 6 characters long", :if => :password
	validates_confirmation_of :password, :message => "doesn't match", :if => :password
end
