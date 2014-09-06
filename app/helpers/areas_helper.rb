module AreasHelper
  
  def self.build_index_xml
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Region {
        xml.id(1)
        xml.Name("VisAge Main Region")
        xml.Areas {
          areas = Area.all
          areas.each do |area|
            xml.Area {
              xml.Name(area.name)
              xml.ZipFileUrl("http://mysterious-hollows-7327.herokuapp.com/api/areas/#{area.id}")
            }
          end
        }
      }
    end
    builder.to_xml    
  end
  
  def self.build_xml (area)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Area {
        xml.Name(area.name)
        xml.ARtype(area.ar_type)
        xml.ARsubtype(area.ar_subtype)
        xml.FeatureDescriptionAlignment(area.feature_description_alignment)
        xml.MaxObjectsToDetectPerFrame(area.max_objects_to_detect_per_frame)
        xml.MaxObjectsToTrackInParallel(area.max_objects_to_track_in_parallel)
        xml.SimilarityThreshold(area.similarity_threshold)
        xml.Pois{          
          area.pois.each do |poi|
            PoiHelper::build_body poi, xml
          end
        }
      }
    end
    builder.to_xml
  end
  
  def self.build_metaio_xml (area)
    metaio = Nokogiri::XML::Builder.new do |xml|
        xml.TrackingData {
          xml.Sensors {
            xml.Sensor(:Type => "FeatureBasedSensorSource", :Subtype => "Fast") {
              xml.SensorId "FeatureTracking1"
              xml.Parameters {
                xml.FeatureDescriptorAlignment area.feature_description_alignment
                xml.MaxObjectsToDetectPerFrame area.max_objects_to_detect_per_frame
                xml.MaxObjectsToTrackInParallel area.max_objects_to_track_in_parallel
                xml.SimilarityThreshold area.similarity_threshold
              }
              
              area.pois.each do |poi|
                xml.SensorCOS {
                  xml.SensorCosID "Patch#{poi.id}"
                  xml.Parameters {
                    xml.ReferenceImage "Patch#{poi.id}.jpg"
                    xml.SimilarityThreshold area.similarity_threshold
                  }
                }
              end
            }
          }
          
          xml.Connections {
            area.pois.each do |poi|
              xml.COS {
                xml.Name "MarkerlessCOS#{poi.id}"
                xml.Fuser(:Type => "BestQualityFuser") {
                  xml.Parameters {
                    xml.KeepPoseForNumberOfFrames 2
                    xml.GravityAssistance
                    xml.AlphaTranslation 0.8
                    xml.GammaTranslation 0.8
                    xml.AlphaRotation 0.5
                    xml.GammaRotation 0.5
                    xml.ContinueLostTrackingWithOrientationSensor false
                  }
                }
                xml.SensorSource {
                  xml.SensorID "FeatureTracking#{poi.id}"
                  xml.SensorCosID "Patch#{poi.id}"
                  xml.HandEyeCalibration {
                    xml.TranslationOffset {
                      xml.X 0
                      xml.Y 0
                      xml.Z 0
                    }
                    xml.RotationOffset {
                      xml.X 0
                      xml.Y 0
                      xml.Z 0
                      xml.W 1
                    }
                  }
                  xml.COSOffset {
                     xml.TranslationOffset {
                      xml.X 0
                      xml.Y 0
                      xml.Z 0
                    }
                    xml.RotationOffset {
                      xml.X 0
                      xml.Y 0
                      xml.Z 0
                      xml.W 1
                    }
                  }
                }
              }
            end
          }
        }
    end
    metaio.to_xml
  end
  
end
