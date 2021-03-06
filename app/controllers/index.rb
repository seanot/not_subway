get '/' do
  # Look in app/views/index.erb
  @all_restaurants = Restaurant.all
  erb :index
end

get '/restaurants' do
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

get '/assumption' do
  @assumption = Restaurant.find(params["assumption"].to_i).to_json
end

get '/restaurant/:id/up' do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.votes += 1
  @restaurant.save
  redirect '/'
end

get '/restaurant/:id/down' do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.votes -= 1
  @restaurant.save
  redirect '/'
end

post '/coords' do
  puts 'FOUND'
  @restaurant = Restaurant.find(params[:id])
  @restaurant.lat = params[:lat]
  @restaurant.lon = params[:lon]
  @restaurant.save
end