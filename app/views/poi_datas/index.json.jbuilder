json.array!(@poi_data) do |poi_data|
  json.extract! poi_data, :id
  json.url poi_data_url(poi_data, format: :json)
end
