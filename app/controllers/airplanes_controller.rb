class AirplanesController < ApplicationController
  before_action :set_airplane, only: [:show, :edit, :update, :destroy]
  #require 'haversine'
  # GET /airplanes
  # GET /airplanes.json
  def index
    s = Setting.where(:use => true).first
    @airplanes = Airplane.order('range')
    @validairplanes = Airplane.where(validposition: 1).where("seen < ?", 60 ).order('range')

  polygon = Geokit::Polygon.new([
  Geokit::LatLng.new(s.originlat, s.originlon),
  Geokit::LatLng.new(s.rightlat, s.rightlon),
  Geokit::LatLng.new(s.leftlat, s.leftlon)
  ])

  piv = Array.new
  @validairplanes.each do |a|

    point = Geokit::LatLng.new(a.lat,a.lon)

    if polygon.contains?(point) == true
     piv << a.id
    end

    @planesinview = Airplane.find(piv)
    #earliest = Model.first(:order => 'column asc')

end


    #raise "test".to_yaml
  end

  # GET /airplanes/1
  # GET /airplanes/1.json
  def show
  end

def refresh
s = Setting.where(:use => true).first

response = HTTParty.get('http://192.168.1.3:8080/dump1090/data.json')
Airplane.destroy_all
response.each do |r|
a = Airplane.new
a.hex = r['hex']
a.sqawk = r['squawk']
a.flight = r['flight']
a.lat = r['lat']
a.lon = r['lon']
a.validposition = r['validposition']
a.altitude = r['altitude']
a.vert_rate = r['vert_rate']
a.track = r['track']
a.validtrack = r['validtrack']
a.speed = r['speed']
a.messages = r['messages']
a.seen = r['seen']
a.mlat = r['mlat']

distance = Haversine.distance(a.lat, a.lon, s.originlat, s.originlon)
a.range = distance.to_miles
a.save
end
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
