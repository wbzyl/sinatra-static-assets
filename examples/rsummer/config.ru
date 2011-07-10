require './summer'

use Rack::ShowExceptions
use Rack::Lint
  
map '/' do
    run Sinatra::Summer.new
end
