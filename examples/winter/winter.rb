# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'

gem 'sinatra-static-assets'
require 'sinatra/static_assets'

get "/?" do
  @title = "Tatra Mountains, Dolina Gąsienicowa (1500 m)"
  erb :index
end
