class Scribble < ActiveRecord::Base
	belongs_to :scribble_type
	belongs_to :user
	before_destroy :delete_from_s3

	def saveImage image
		s3_object.write(image)
		scribble_type.increment!(:count)
		save
	end

	def url
		'https://s3-eu-west-1.amazonaws.com/scribblescramble/'+s3_key
	end

	private
    def delete_from_s3
      s3_object.delete
      scribble_type.decrement!(:count)
    end

    def s3_object
    	AWS::S3.new.buckets['scribblescramble'].objects[s3_key]
	end
end