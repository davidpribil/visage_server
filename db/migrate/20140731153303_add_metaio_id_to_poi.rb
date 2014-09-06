class AddMetaioIdToPoi < ActiveRecord::Migration
  def change
    add_column :pois, :metaio_id, :string
  end
end
