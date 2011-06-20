# -*- coding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/static_assets'

module Sinatra
  class Summer < Sinatra::Base
    register Sinatra::StaticAssets

    set :app_file,  __FILE__
    set :static, true

    get '/?' do
      @title = "Tatra Mountains, Błyszcz (2159 m)"
      erb :index
    end
  end
end
