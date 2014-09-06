class AddAreaIdToPoi < ActiveRecord::Migration
  def change
    add_column :pois, :area_id, :integer
  end
end
