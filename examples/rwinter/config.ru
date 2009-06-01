require 'winter'

use Rack::ShowExceptions
use Rack::Lint
  
map '/' do
    run Sinatra::Winter.new
end
