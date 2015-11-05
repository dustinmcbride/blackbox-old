class Airplane < ActiveRecord::Base




def self.refresh
  s = Setting.where(:use => true).first

  response = HTTParty.get('http://192.168.1.3:8080/dump1090/data.json')
  Airplane.destroy_all
  response.each do |r|
  a = self.new
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
end

end
