class AddBasicRoom < ActiveRecord::Migration
  def self.up
    create_table "basic_objects", :force => true do |t|
      t.string :name, :limit => 80
      t.string :type, :limit => 80

      t.string :base_description, :limit => 240

      # These are used for serialized fields
      t.text :tags
      t.text :descriptions

      t.timestamps
    end

    create_table "basic_exits", :force => true do |t|
      t.integer :basic_object_id, :null => false
      t.integer :destination_id, :null => false
      t.string :type, :limit => 80
      t.string :name, :limit => 80
      t.string :description, :limit => 240
      t.text :tags
      t.timestamps
    end

    create_table "basic_mobiles", :force => true do |t|
      t.integer :current_room_id
      t.integer :current_body_id
      t.string :name, :limit => 80
      t.string :type, :limit => 80

      # Serialized fields
      t.text :tags
      t.text :descriptions

      t.timestamps
    end
  end

  def self.down
    drop_table "basic_objects"
    drop_table "basic_exits"
    drop_table "basic_mobiles"
  end
end
