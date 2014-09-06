class AddPoiDataIdToPoiDataLocation < ActiveRecord::Migration
  def change
    add_column :poi_data_locations, :poi_data_id, :integer
    add_index :poi_data_locations, [:poi_data_id, :created_at]
  end
end
