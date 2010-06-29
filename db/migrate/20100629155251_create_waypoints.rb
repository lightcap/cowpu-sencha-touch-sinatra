class CreateWaypoints < ActiveRecord::Migration
  def self.up
    create_table :waypoint_types do |t|
      t.string :name, :limit => 100
    end
    
    create_table :waypoints do |t|
      t.string :title, :limit => 100
      t.text :description
      t.int :waypoint_type_id
      t.float :latitude, :length => 10
      t.float :longitude, :length => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :waypoint_types
    drop_table :waypoints
  end
end
