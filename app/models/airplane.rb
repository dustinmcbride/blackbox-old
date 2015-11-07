class Airplane < ActiveRecord::Base


def inview
  s = Setting.where(:use => true).first

  polygon = Geokit::Polygon.new([
  Geokit::LatLng.new(s.originlat, s.originlon),
  Geokit::LatLng.new(s.rightlat, s.rightlon),
  Geokit::LatLng.new(s.leftlat, s.leftlon)
  ])

    point = Geokit::LatLng.new(self.lat,self.lon)
    polygon.contains?(point)
end



def getlcdmessage
  msg = Array.new

  if self.flight.blank? == true
    l1 = "#{self.hex} A:#{self.altitude}"
    l2 = "R:#{self.range.round(1)} S:#{self.speed}"
  else
    l1 = "#{self.flight} A:#{self.altitude}"
    l2 = "R:#{self.range.round(1)} S:#{self.speed}"
  end
  msg = l1, l2
  msg
end


def self.refresh
  s = Setting.where(:use => true).first

  response = HTTParty.get(s.dump1090url)
  Airplane.destroy_all
  #reset_pk_sequence!
    response.each do |r|

      if r['validposition'] == 1
        if r['seen'] < 60

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

      #record if plan is in view
      a.is_inview = a.inview
      a.save

      end
    end
  end
end
end
