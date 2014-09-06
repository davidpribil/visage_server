module Api
  class PoisController < ApplicationController
    
    include Compression
    before_action :set_poi, only: [:show]  
    
    def show
      xml = PoiHelper::build_xml @poi
      zipper = Zipper.new
      zipper.add_data("poi_data.xml", xml)
      zip_data = zipper.finish
      send_data zip_data, :type => 'application/zip', :filename => "test.zip"
    end
    
    private
    
      def set_poi
        @poi = Poi.find(params[:id])
      end
    
  end
end