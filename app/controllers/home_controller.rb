require 'uri'
require 'net/http'

class HomeController < ApplicationController
  def index


url = ENV["URL"]
uri = URI(url)
res = Net::HTTP.get_response(uri)

@data = JSON.parse(res.body)

  end
end


# http://openweathermap.org/img/wn/10d@2x.png
