require 'rsummer/mapp'
require 'rwinter/mapp'

Rapp = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Lint
  
  map '/mapp1' do
    run Sinatra::Mapp1.new
  end
  
  map '/mapp2' do
    run Sinatra::Mapp2.new
  end
end

run Rapp
