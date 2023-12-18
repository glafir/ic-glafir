require 'uri'
require 'net/http'
require 'json'
lat = "25.077731"
lon = "121.232822"
#api_type = "forecast"
api_type = "weather"

uri = URI("https://api.openweathermap.org/data/2.5/#{api_type}?lat=#{lat}&lon=#{lon}&appid=1cc9a2a59f851e39dfcfa8e29b62d584")
#uri = URI("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
Net::HTTP.start(uri.host, uri.port, read_timeout: 120, open_timeout: 120, use_ssl: uri.scheme == 'https') do |http|
  http.ssl_version = 'TLSv1'
  ### -- or SSLv3, but TLSv1 is better
  http.ciphers = 'rc4-sha'
  request = Net::HTTP::Get.new uri
  response = http.request request # Net::HTTPResponse object
  p json = JSON.parse(response.body)['weather']
  json.each {|k|
    p "#{k['id']} #{k['main']} #{k['description']} #{k['icon']}"
  }
end
