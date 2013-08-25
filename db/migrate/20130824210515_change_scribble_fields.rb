class ChangeScribbleFields < ActiveRecord::Migration
  def change
  	add_column :scribbles, :user_id, :integer
  	add_column :scribbles, :last_rated, :integer, default: 0
  	
  	add_index :scribbles, :scribble_type_id, name: "type_index"

  	add_column :scribble_types, :count, :integer, default: 0
  end
end
