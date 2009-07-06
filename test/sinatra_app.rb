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

get "/stylesheet_link_tag" do
  content_type "text/plain"
  <<"EOD"
#{stylesheet_link_tag("/stylesheets/winter.css", "/stylesheets/summer.css", :media => "projection")}
EOD
end

get "/javascript_script_tag" do
  content_type "text/plain"
  <<"EOD"
#{javascript_script_tag "/javascripts/summer.js", :charset => "iso-8859-2"}
EOD
end

get "/link_to_tag" do
  content_type "text/plain"
  <<"EOD"
#{link_to "Tatry Mountains Rescue Team", "/topr"}
EOD
end
