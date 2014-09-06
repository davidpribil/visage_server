class AddPoiIdToPoiData < ActiveRecord::Migration
  def change
    add_column :poi_data, :poi_id, :integer
    add_index :poi_data, [:poi_id, :created_at]
  end
end
