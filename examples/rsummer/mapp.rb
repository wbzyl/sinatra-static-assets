# -*- coding: utf-8 -*-

require 'sinatra/base'

gem 'sinatra-static-assets'
require 'sinatra/static_assets'

module Sinatra
  class Mapp1 < Sinatra::Base
    helpers Sinatra::UrlForHelper
    helpers Sinatra::StaticAssets
    
    set :app_file,  __FILE__
    set :static, true  
    
    #set :root, File.dirname(__FILE__)
    #set :views, Proc.new { File.join(root, "views") }
    
    get '/' do
      @title = "Tatra Mountains, Błyszcz (2159 m)"
      erb :app
    end
  end
end
