class ColumnChangeRestaurants < ActiveRecord::Migration
  def change
    rename_column :restaurants, :type, :food_type
  end
end
