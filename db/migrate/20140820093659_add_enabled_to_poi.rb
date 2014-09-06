class AddEnabledToPoi < ActiveRecord::Migration
  def change
    add_column :pois, :enabled, :boolean, default: false
  end
end
