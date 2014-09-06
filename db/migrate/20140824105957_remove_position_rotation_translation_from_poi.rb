class RemovePositionRotationTranslationFromPoi < ActiveRecord::Migration
  def change
    remove_column :poi_datas, :position
    remove_column :poi_datas, :rotation
    remove_column :poi_datas, :scale
  end
end
