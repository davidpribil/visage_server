# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Area 1
area = Area.create(name: "Test", ar_type: "artype", ar_subtype: "arsubtype", feature_description_alignment: 1, max_objects_to_detect_per_frame: 2, max_objects_to_track_in_parallel: 3, similarity_threshold: 0.7)
# Poi 1
poi = area.pois.create(metaio_id: "Patch1", name: "Queens Gardens", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/1/Queens_Gardens_base3.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D",  file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/1/Queens_Gardens_small.jpg') do |f|
  poi.marker_image = f.read
  poi.save
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

# Poi 2
poi = area.pois.create(metaio_id: "Patch2", name: "Elm Guest House", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/1/Elm-Guest-House-in-Barnes.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D",  file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/1/Elm-Guest-House-in-Barnes_small.jpg') do |f|
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

area.save


# Area 2
area = Area.create(name: "MaletPlace", ar_type: "artype", ar_subtype: "arsubtype", feature_description_alignment: 1, max_objects_to_detect_per_frame: 2, max_objects_to_track_in_parallel: 3, similarity_threshold: 0.7)

# Poi 1
poi = area.pois.create(metaio_id: "Patch1", name: "01", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/2/01.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D", file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/2/01_small.jpg') do |f|
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

# Poi 2
poi = area.pois.create(metaio_id: "Patch2", name: "02", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/2/02.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D",  file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/2/02_small.jpg') do |f|
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

# Poi 3
poi = area.pois.create(metaio_id: "Patch3", name: "04", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/2/04.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D",  file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/2/04_small.jpg') do |f|
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

# Poi 4
poi = area.pois.create(metaio_id: "Patch4", name: "09", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/2/09.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D",  file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/2/09_small.jpg') do |f|
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

# Poi 5
poi = area.pois.create(metaio_id: "Patch5", name: "10", target_height: 1.0, target_width: 1.0, gps_latitude: 1.0, gps_longitude: 1.0, similarity_threshold: 0.5)
File.open('data/2/10.jpg') do |f|
  poi.poi_datas.create(data_type: "texture2D",  file: f.read, filename: File.basename(f), description: "test_poi_data")
end
File.open('data/2/10_small.jpg') do |f|
  poi.poi_datas.create(data_type: "metaio_config", file: f.read, filename: File.basename(f))
end

area.save


