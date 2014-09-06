class ArTargetsController < ApplicationController
  before_action :set_ar_target, only: [:show, :edit, :update, :destroy]

  # GET /ar_targets
  # GET /ar_targets.json
  def index
    @ar_targets = ArTarget.all
  end

  # GET /ar_targets/1
  # GET /ar_targets/1.json
  def show
  end

  # GET /ar_targets/new
  def new
    @ar_target = ArTarget.new
  end

  # GET /ar_targets/1/edit
  def edit
  end

  # POST /ar_targets
  # POST /ar_targets.json
  def create
    @ar_target = ArTarget.new(ar_target_params)

    respond_to do |format|
      if @ar_target.save
        format.html { redirect_to @ar_target, notice: 'Ar target was successfully created.' }
        format.json { render :show, status: :created, location: @ar_target }
      else
        format.html { render :new }
        format.json { render json: @ar_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ar_targets/1
  # PATCH/PUT /ar_targets/1.json
  def update
    respond_to do |format|
      if @ar_target.update(ar_target_params)
        format.html { redirect_to @ar_target, notice: 'Ar target was successfully updated.' }
        format.json { render :show, status: :ok, location: @ar_target }
      else
        format.html { render :edit }
        format.json { render json: @ar_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ar_targets/1
  # DELETE /ar_targets/1.json
  def destroy
    @ar_target.destroy
    respond_to do |format|
      format.html { redirect_to ar_targets_url, notice: 'Ar target was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ar_target
      @ar_target = ArTarget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ar_target_params
      params.require(:ar_target).permit(:name, :image_url, :data_url, :description)
    end
end
