class AddSourceToPoiDataLocation < ActiveRecord::Migration
  def change
    add_column :poi_data_locations, :source, :string
  end
end
