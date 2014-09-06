module PoiHelper
  def self.build_xml (poi, root_xml = nil)
    if root_xml
      build_body poi, root_xml
    else
      builder = Nokogiri::XML::Builder.new do |xml|
        build_body poi, xml
      end
    builder.to_xml
    end
  end

  def self.build_body (poi, xml)
    xml.Poi {
      xml.PoiId("Patch#{poi.id}")
      xml.Name(poi.name)
      xml.TargetHeight(poi.target_height)
      xml.TargetWidth(poi.target_width)
      xml.GPSlatitude(poi.gps_latitude)
      xml.GPSlongitude(poi.gps_longitude)
      xml.SimilarityThreshold(poi.similarity_threshold)
      xml.PoiDatas {
        poi.poi_data_locations.each do |poi_data_location|
          poi_data = PoiData.find poi_data_location.poi_data_id
          if poi_data.metaio_config?
          next
          end
          xml.PoiData {
            xml.PoiDataId(poi_data.id)
            xml.PoiDataTypeId(poi_data.data_type)
            xml.Description(poi_data_location.source)
            if poi_data_location.position
              xml.Position {
                xml.x(poi_data_location.position[0])
                xml.y(poi_data_location.position[1])
                xml.z(poi_data_location.position[2])
              }
            end
            if poi_data_location.rotation
              xml.Rotation {
                xml.x(poi_data_location.rotation[0])
                xml.y(poi_data_location.rotation[1])
                xml.z(poi_data_location.rotation[2])
              }
            end
            if poi_data_location.scale
              xml.Scale {
                xml.x(poi_data_location.scale[0])
                xml.y(poi_data_location.scale[1])
                xml.z(poi_data_location.scale[2])
              }
            end
            xml.File(poi_data.filename)
          }
        end
      }

    }
  end
  
  
end
