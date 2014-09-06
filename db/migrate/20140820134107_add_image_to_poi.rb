class AddImageToPoi < ActiveRecord::Migration
  def change
    add_column :pois, :marker_image, :binary
  end
end
