class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :ar_type
      t.string :ar_subtype
      t.string :feature_description_alignment
      t.integer :max_objects_to_detect_per_frame
      t.integer :max_objects_to_track_in_parallel
      t.float :similarity_threshold

      t.timestamps
    end
  end
end
