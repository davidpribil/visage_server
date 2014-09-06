class AddTypeToPoiData < ActiveRecord::Migration
  def change
    add_column :poi_data, :type, :integer, default: 0
    remove_column :pois, :image
  end
end
