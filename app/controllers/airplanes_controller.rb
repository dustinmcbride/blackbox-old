class AirplanesController < ApplicationController
  before_action :set_airplane, only: [:show, :edit, :update, :destroy]
  #require 'haversine'
  # GET /airplanes
  # GET /airplanes.json
  def index
    s = Setting.where(:use => true).first
    @airplanes = Airplane.order('range')
    @planesinview = Airplane.where(:is_inview => true).order('range')
    @lcdmessage = @planesinview.first.getlcdmessage



end





  # GET /airplanes/1
  # GET /airplanes/1.json
  def show
  end

def refresh
#system "python ./vendor/python/writetolcd.py \"test\" \"testline\""
Airplane.refresh
redirect_to airplanes_url
end




  # GET /airplanes/new
  def new
    @airplane = Airplane.new
  end

  # GET /airplanes/1/edit
  def edit
  end

  # POST /airplanes
  # POST /airplanes.json
  def create
    @airplane = Airplane.new(airplane_params)

    respond_to do |format|
      if @airplane.save
        format.html { redirect_to @airplane, notice: 'Airplane was successfully created.' }
        format.json { render :show, status: :created, location: @airplane }
      else
        format.html { render :new }
        format.json { render json: @airplane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airplanes/1
  # PATCH/PUT /airplanes/1.json
  def update
    respond_to do |format|
      if @airplane.update(airplane_params)
        format.html { redirect_to @airplane, notice: 'Airplane was successfully updated.' }
        format.json { render :show, status: :ok, location: @airplane }
      else
        format.html { render :edit }
        format.json { render json: @airplane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airplanes/1
  # DELETE /airplanes/1.json
  def destroy
    @airplane.destroy
    respond_to do |format|
      format.html { redirect_to airplanes_url, notice: 'Airplane was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airplane
      @airplane = Airplane.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def airplane_params
      params.require(:airplane).permit(:hex, :sqawk, :flight, :lat, :lon, :validposition, :altitude, :vert_rate, :track, :validtrack, :speed, :messages, :seen, :mlat)
    end
end
