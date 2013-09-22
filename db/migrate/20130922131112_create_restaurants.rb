class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :lat_long
      t.string :type
      t.integer :avg_price
      t.integer :votes, default: 0
      t.string :url
      t.timestamps
    end
  end
end
