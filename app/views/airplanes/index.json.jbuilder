json.array!(@airplanes) do |airplane|
  json.extract! airplane, :id, :hex, :sqawk, :flight, :lat, :lon, :validposition, :altitude, :vert_rate, :track, :validtrack, :speed, :messages, :seen, :mlat
  json.url airplane_url(airplane, format: :json)
end
