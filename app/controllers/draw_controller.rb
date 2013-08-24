class DrawController < ApplicationController

	def index
		@target = "a duck"
	end

	def save
		image = Base64.decode64(params[:data]);

		#File.open("testing.png","wb") do |f|
		#	f.write(image);
		#end

		bucket.objects[getKey params[:target]].write(image)

		redirect_to :root
	end

	private

	def bucket
		s3 = AWS::S3.new
		s3.buckets['scribblescramble']
	end

	def getKey target
		target.tr(' ','_')+"_"+(1000.0*Time.now.to_f).to_i.to_s+".png"
	end

end