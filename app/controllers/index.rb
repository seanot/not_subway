get '/' do
  # Look in app/views/index.erb
  @all_restaurants = Restaurant.all
  erb :index
end

get '/restaurants' do
  # @assumption = Restaurant.find(params["assumption"].to_i)
  @assumption = Restaurant.find(params["assumption"].to_i)
  results = []
  Restaurant.all.each do |restaurant|
    if restaurant.name != @assumption.name && restaurant.avg_price <= @assumption.avg_price + 5
      results.push(restaurant)
    end
  end
  if request.xhr?
    results.to_json
  else
    erb :restaurants
  end
end
