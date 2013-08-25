class CreateScribblesAndScribbleTypes < ActiveRecord::Migration
  def change
  	create_table :scribble_types do |t|
      t.string 		:name
      t.string 		:full_name
    end

    create_table :scribbles do |t|
      t.string		:s3_key
      t.references 	:scribble_type
      t.boolean 	:rated, default: false
    end
  end
end