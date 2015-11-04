json.array!(@settings) do |setting|
  json.extract! setting, :id, :location, :leftpoint, :rightpoint, :cloudceiling, :sunset, :sunrise, :dayrange, :nightrange
  json.url setting_url(setting, format: :json)
end
