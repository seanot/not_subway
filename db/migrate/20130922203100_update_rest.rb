class UpdateRest < ActiveRecord::Migration
  def change
    remove_column :restaurants, :lat_long
    add_column :restaurants, :lat, :float
    add_column :restaurants, :lon, :float
  end
end
