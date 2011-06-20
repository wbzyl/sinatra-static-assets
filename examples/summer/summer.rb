# -*- coding: utf-8 -*-

require 'sinatra'
require 'sinatra/static_assets'

get "/?" do
  @title = "Tatra Mountains, Błyszcz (2159 m)"
  erb :index
end

get "/:page" do
  @title = "#{params[:page]}"
  erb :"#{params[:page]}"
end
