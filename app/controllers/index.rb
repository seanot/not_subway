get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/restaurants' do
  @assumption = Restaurant.find(params[:id])
  results = []
  Restaurant.all.each do |restaurant|
    if restaurant.name != @assumption.name && restaurant.avg_price <= @assumption.avg_price + 5
      results.push(restaurant)
    end
  end
  if request.xhr?
    results
  else
    erb :restaurants
  end
end
