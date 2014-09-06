class CreatePois < ActiveRecord::Migration
  def change
    create_table :pois do |t|
      t.string :name
      t.float :target_height
      t.float :target_width
      t.float :gps_latitude
      t.float :gps_longitude
      t.binary :image
      t.float :similarity_threshold

      t.timestamps
    end
  end
end
