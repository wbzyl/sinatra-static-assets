require 'rubygems'

require 'sinatra'
require 'sinatra/url_for'

get "/" do
  content_type "text/plain"
  <<"EOD"
#{url_for("/")}
#{url_for("/foo")}
#{url_for("/foo", :full)}
EOD
end
