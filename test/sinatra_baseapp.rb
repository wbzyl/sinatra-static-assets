path = File.expand_path("../lib" + File.dirname(__FILE__))
$:.unshift(path) unless $:.include?(path)

require 'rubygems'
require 'sinatra/base'

require 'sinatra/static_assets'

module Sinatra
  class XHTML < Sinatra::Base
    helpers Sinatra::UrlForHelper
    register Sinatra::StaticAssets

    enable :xhtml
    
    get '/image_tag' do
      content_type "text/plain"
      "#{image_tag("/images/foo.jpg")}"
    end

    get '/link_tag' do
      content_type "text/plain"
      "#{stylesheet_link_tag("/stylesheets/winter.css")}"
    end
  end
end
