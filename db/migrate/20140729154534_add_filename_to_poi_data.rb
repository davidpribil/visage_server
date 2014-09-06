class AddFilenameToPoiData < ActiveRecord::Migration
  def change
    add_column :poi_data, :filename, :string
  end
end
