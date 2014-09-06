class PoiDatasController < ApplicationController
  before_action :set_poi_data, only: [:show, :edit, :update, :destroy]
  before_action :set_area_poi

  # GET /poi_data
  # GET /poi_data.json
  def index
    @poi_datas = PoiData.all
  end

  # GET /poi_data/1
  # GET /poi_data/1.json
  def show
  end

  # GET /poi_data/new
  def new
    @poi_data = @poi.poi_datas.new
  end

  # GET /poi_data/1/edit
  def edit
  end

  # POST /poi_data
  # POST /poi_data.json
  def create
    data = poi_data_params[:file]
    poi_data_params[:file] = nil
    @poi_data = @poi.poi_datas.new(poi_data_params)
    @poi_data.file = data.read
    @poi_data.filename = data.original_filename
    
    respond_to do |format|
      if @poi_data.save
        format.html { redirect_to edit_area_poi_path(@area, @poi), notice: 'Poi data was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /poi_data/1
  # PATCH/PUT /poi_data/1.json
  def update
    respond_to do |format|
      if @poi_data.update(poi_data_params)
        format.html { redirect_to @poi_data, notice: 'Poi data was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /poi_data/1
  # DELETE /poi_data/1.json
  def destroy
    @poi_data.destroy
    respond_to do |format|
      format.html { redirect_to poi_data_url, notice: 'Poi data was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poi_data
      @poi_data = PoiData.find(params[:id])
    end
    
    def set_area_poi
      @area = Area.find(params[:area_id])
      @poi = Poi.find(params[:poi_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poi_data_params
      params.require(:poi_data).permit!
    end
    
end
