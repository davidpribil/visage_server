module Api
  class AreasController < ApplicationController

    include Compression
    before_action :set_area, only: [:show]
    
    def new
      @area = Area.new
    end

    def index
      send_data AreasHelper::build_index_xml, :type => 'text/xml', :filename => "VisAgeRegion.xml"
    end

    def show
      xml = AreasHelper::build_xml @area
      # add all the resources as files
      zipper = Zipper.new
      # main folder
      zipper.enter_dir "#{@area.name}"
      # add resources type data
      # main xml
      zipper.add_data("Data_#{@area.name}.xml", xml)
      # other resources data
      @area.pois.each do |poi|
        poi.poi_data_locations.each do |poi_data_location|
          poi_data = PoiData.find poi_data_location.poi_data_id
          if !poi_data.metaio_config? && poi_data.filename
            zipper.add_data "#{poi_data.filename}", poi_data.file
          end
        end
      end

      # add metaio related data
      zipper.enter_dir "StreamingAssets"
      
      xml = AreasHelper::build_metaio_xml @area
      zipper.add_data("TrackingData_#{@area.name}.xml", xml)
      
      @area.pois.each do |poi|
        if poi.marker_image
          zipper.add_data "Patch#{poi.id}.jpg", poi.marker_image
        end
        poi.poi_datas.each do |poi_data|
          if poi_data.metaio_config? && poi_data.filename
            zipper.add_data "#{poi_data.filename}", poi_data.file
          end
        end
      end

      zip_data = zipper.finish
      send_data zip_data, :type => 'application/zip', :filename => "#{@area.name}.zip"
    end

    def upload
      uploaded_io = params[:person][:picture]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end

    private

    def set_area
      @area = Area.find(params[:id])
    end

  end
end