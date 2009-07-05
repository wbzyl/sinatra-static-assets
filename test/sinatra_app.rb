require 'rubygems'

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/static_assets'

get "/url_for" do
  content_type "text/plain"
  <<"EOD"
#{url_for("/")}
#{url_for("/foo")}
#{url_for("/foo", :full)}
EOD
end

get "/image_tag" do
  content_type "text/plain"
  <<"EOD"
#{image_tag("/images/foo.jpg", :alt => "[foo image]")}
EOD
end
