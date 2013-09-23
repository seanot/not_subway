require 'csv'
# require 'restaurants.csv'

CSV.foreach("db/restaurants.csv", :headers => true, :header_converters => :symbol) do |row|
  r = Restaurant.new(name: row[:name],
                    avg_price: row[:average_price],
                    address: row[:address] + " " + row[:zip],
                    food_type: row[:food_type])
  if r.food_type.length > 30
  	r.food_type = r.food_type[0..29]
  end
  if r.avg_price != 0 && !r.name.downcase.include?('closed')
  	r.save
  end
end

