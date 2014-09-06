class ChnageNameInPoiData < ActiveRecord::Migration
  def change
    rename_column :poi_data, :type, :data_type
  end
end
