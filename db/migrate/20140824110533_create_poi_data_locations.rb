class CreatePoiDataLocations < ActiveRecord::Migration
  def change
    create_table :poi_data_locations do |t|
      t.string :position
      t.string :rotation
      t.string :scale

      t.timestamps
    end
  end
end
