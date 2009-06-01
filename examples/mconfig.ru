require 'mapp1/mapp'
require 'mapp2/mapp'

Mapp = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Lint
  
  #use Rack::Static, :urls => ["/stylesheets", "/images"], :root => "public"

  map '/mapp1' do
    run Sinatra::Mapp1.new
  end
  
  map '/mapp2' do
    run Sinatra::Mapp2.new
  end
end

run Mapp
