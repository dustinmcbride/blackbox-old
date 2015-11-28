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

    if self.flight == ""
      num = self.flight
    else
      num = self.hex
    end

    l1 = "#{num} A:#{self.altitude} #{self.getdirectiontolook}"
    l2 = "R:#{self.range.round(1)} S:#{self.speed}"

  msg = l1, l2
  msg
end




def getdirectiontolook
  s = Setting.where(:use => true).first
  horizon = [s.rightlat, s.leftlat, s.farrightlat, s.farleftlat]
  left =  horizon.compact.min
  right =  horizon.compact.max
  distance = right - left

  lookleft = left + (distance * 0.20)
  lookleftcenter = left + (distance * 0.40)
  lookcenter = left + (distance * 0.60)
  lookrightcenter = left + (distance * 0.80)
  lookright = left + (distance * 1)

  a = self.lat

  direction = "<" if a.between?(left,lookleft) == true
  direction = "\u2216" if a.between?(lookleft,lookleftcenter) == true
  direction = "^" if a.between?(lookleftcenter,lookcenter) == true
  direction = "/" if a.between?(lookcenter,lookrightcenter) == true
  direction = ">" if a.between?(lookrightcenter,lookright) == true

  direction
end


def self.refresh
  s = Setting.where(:use => true).first

  response = HTTParty.get(s.dump1090url)
  Airplane.delete_all

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
