require 'rubygems'
require 'sinatra/base'

require 'sinatra/static_assets'

module Sinatra
  class XHTML < Sinatra::Base
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
    
    get '/link_favicon_tag' do
      content_type "text/plain"
      "#{link_favicon_tag("favicon.ico")}"
    end
  end
end
