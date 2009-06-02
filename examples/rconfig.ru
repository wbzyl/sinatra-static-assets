$LOAD_PATH.unshift('rsummer')
require 'summer'

$LOAD_PATH.unshift('rwinter')
require 'winter'

map '/summer' do
  run Sinatra::Summer.new
end
  
map '/winter' do
  run Sinatra::Winter.new
end
