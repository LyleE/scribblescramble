class ScribbleType < ActiveRecord::Base
  has_many :scribbles

  def self.random
  	offset(rand(count)).first
  end

  def self.random_rateable
  	rateable = where("count > 1")
  	rateable[rand(rateable.length)]
  end

end