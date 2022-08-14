require 'uri'
require 'net/http'

class HomeController < ApplicationController
  def index


url = 'https://api.openweathermap.org/data/2.5/weather?q=kolkata&appid=a878768efc383e2dc35a3b44734f30ff'
uri = URI(url)
res = Net::HTTP.get_response(uri)

@data = JSON.parse(res.body)

  end
end


# http://openweathermap.org/img/wn/10d@2x.png
# https://api.openweathermap.org/data/2.5/weather?q=kolkata&appid=a878768efc383e2dc35a3b44734f30ff