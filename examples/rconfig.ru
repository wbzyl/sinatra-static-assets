require 'rsummer/summer'
require 'rwinter/winter'

map '/summer' do
  run Sinatra::Summer.new
end
  
map '/winter' do
  run Sinatra::Winter.new
end
