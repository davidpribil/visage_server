class CreateArTargets < ActiveRecord::Migration
  def change
    create_table :ar_targets do |t|
      t.string :name
      t.string :image_url
      t.string :data_url
      t.string :description

      t.timestamps
    end
  end
end
