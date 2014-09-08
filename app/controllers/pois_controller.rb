class PoisController < ApplicationController
  before_action :set_poi, only: [:show, :edit, :update, :destroy]  
  before_action :set_area
  before_action :signed_in_user
  
  def new
    @poi = @area.pois.new
  end
  
  def index
    @pois = @area.pois.all
  end
  
  def create
    @poi = @area.pois.new(poi_params)
    @poi.similarity_threshold = @area.similarity_threshold
        
    respond_to do |format|
      if @poi.save
        flash[:success] = 'Poi was successfully created.'
        format.html {redirect_to @area}
      else
        format.html {render :new}
      end
    end
    
  end
  
  def update
    respond_to do |format|
      # clear tabs
      @poi.tab_data = params[:poi_tab_data]
      
      # add objects
      if params[:poi_datas_location]
        extra = JSON.parse params[:poi_datas_location]
        ids = [];
        extra.each do |e|
          hash = e[1]
          position_params = {position: [hash['x'], hash['y'], 0],
                             scale: [hash['w'], hash['h'], 0],
                             rotation: [0,0,0],
                             source: hash['source'],
                             tab_id: hash['tab_id']}
          poi_data_id = hash['poi_data_id']
          poi_data_location_id = hash['poi_data_location_id']
          if PoiDataLocation.exists? poi_data_location_id
            id = PoiDataLocation.update(poi_data_location_id,position_params).id
          elsif PoiData.exists? poi_data_id
            id = PoiData.find(poi_data_id).poi_data_locations.create(position_params).id
          end
          if id
            ids << id
          end
        end
      end
      
      # remove deleted data
      @poi.poi_data_locations.each do |loc|
        unless ids.include? loc.id
          loc.destroy
        end
      end
      
      data = poi_params[:marker_image]
      if(data) 
        poi_params[:marker_image] = data.read;
      end
      if @poi.update(poi_params)
        flash[:success] = 'Poi was successfully updated.'
        format.html { redirect_to edit_area_poi_path(@area, @poi)}
      else
        format.html { render :edit }
      end
    end
  end
  
  def show
  end
  
  def updateLocation
    poi = Poi.find(params[:poi_id])
    poi.gps_latitude = params[:lat]
    poi.gps_longitude = params[:lon]
    poi.save
    render nothing: true
  end
  
  def destroy
    @poi.destroy
    respond_to do |format|
      flash[:success] = 'Poi was successfully deleted.'
      format.html { redirect_to @area}
    end
  end
  
  private
  
    def set_area
      @area = Area.find(params[:area_id])
    end
  
    def set_poi
      @poi = Poi.find(params[:id])
    end
    
    def poi_params
      params.require(:poi).permit!
    end
    
  
end