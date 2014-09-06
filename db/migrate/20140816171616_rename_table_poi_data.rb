class RenameTablePoiData < ActiveRecord::Migration
  def change
    rename_table :poi_data, :poi_datas
  end
end
