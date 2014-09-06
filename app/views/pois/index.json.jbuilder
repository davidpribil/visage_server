json.array!(@pois) do |poi|
  json.id poi.id
  json.lat poi.gps_latitude
  json.lng poi.gps_longitude  
end