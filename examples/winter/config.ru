# run with:  thin --rackup config.ru -p 4567 start

require 'app2'

use Rack::ShowExceptions
use Rack::Static, :urls => ["/stylesheets", "/javascripts", "/images"], :root => "public"
run Sinatra::Application
