require 'csv'
# require 'restaurants.csv'

CSV.foreach("db/restaurants.csv", :headers => true, :header_converters => :symbol) do |row|
  Restaurant.create(name: row[:name],
                    avg_price: row[:average_price],
                    address: row[:address] + " " + row[:zip],
                    food_type: row[:food_type])
end

