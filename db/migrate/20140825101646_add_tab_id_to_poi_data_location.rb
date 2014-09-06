class AddTabIdToPoiDataLocation < ActiveRecord::Migration
  def change
    add_column :poi_data_locations, :tab_id, :integer
    add_column :pois, :tab_data, :string
  end
end
