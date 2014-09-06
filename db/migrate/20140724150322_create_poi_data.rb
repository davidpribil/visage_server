class CreatePoiData < ActiveRecord::Migration
  def change
    create_table :poi_data do |t|
      t.string :description
      t.string :position
      t.string :rotation
      t.string :scale
      t.binary :file

      t.timestamps
    end
  end
end
