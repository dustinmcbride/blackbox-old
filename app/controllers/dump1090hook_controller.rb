class Dump1090hookController < ApplicationController
skip_before_action :verify_authenticity_token, only: [:dump]
#http_basic_authenticate_with name: "user", password: "secret"


  # POST /settings
  # POST /settings.json
  def dump
    @dump = params
    s = Setting.where(:use => true).first
  #  curl -o sampledump1090data.json http://piaware.local:8080/dump1090/data.json
#   curl -X POST -d @sampledump1090data.json -H "Content-type: application/json" --user user:secret http://localhost:3000/dump1090hook.json
   #json sample {"hex":"a82903","squawk":"6634","flight":"","lat":0.0,"lon":0.0,"validposition":0,"altitude":10550,"vert_rate":0,"track":0,"validtrack":0,"speed":0,"messages":181,"seen":0,"mlat":false}
   planedata = p params["_json"]

   Airplane.delete_all

   planedata.each do |a|
     if a['validposition'] == 1
       if a['seen'] < 60

          na = Airplane.new
          logger.info a["hex"]
          na.hex = a["hex"]
          na.sqawk = a["squak"]
          na.flight = a["flight"]
          na.lat= a["lat"]
          na.lon = a["lon"]
          na.validposition = a["validposition"]
          na.altitude = a["altitude"]
          na.vert_rate = a["vert_rate"]
          na.track = a["track"]
          na.validtrack = a["validtrack"]
          na.speed = a["speed"]
          na.messages = a["messages"]
          na.seen = a["seen"]
          na.mlat = a["mlat"]

          distance = Haversine.distance(na.lat, na.lon, s.originlat, s.originlon)

          na.range = distance.to_miles
          na.save

          na.save

          #record if plan is in view
          na.is_inview = na.inview
          na.save

          end
        end
      end


   render json: @dump
  end


end
