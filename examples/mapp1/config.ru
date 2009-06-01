require 'mapp'

Mapp1 = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Lint
  
  use Rack::Static, :urls => ["/stylesheets", "/images"], :root => "public"

  map '/' do
    run Sinatra::Mapp1.new
  end
end

run Mapp1
