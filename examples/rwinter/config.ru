require 'mapp'

Mapp2 = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Lint
  
  use Rack::Static, :urls => ["/stylesheets", "/images"], :root => "public"
  
  map '/' do
    run Sinatra::Mapp2.new
  end
end

run Mapp2
