class DrawController < ApplicationController

	def index
		# Get a random scribble type!
		@type = ScribbleType.first(:offset => rand(ScribbleType.count))
	end

	def save
		image = Base64.decode64(params[:data]);
		type = ScribbleType.find(params[:type_id])

		if(!type)
			render status: 400, text: "uh oh"
		end

		key = getKey type

		bucket.objects[ key ].write(image)

		Scribble.create(s3_key: key, scribble_type_id: type.id)

		redirect_to :root
	end

	private

	def bucket
		s3 = AWS::S3.new
		s3.buckets['scribblescramble']
	end

	def getKey type
		type.name.tr(' ','_')+"_"+(1000.0*Time.now.to_f).to_i.to_s+".png"
	end

end