require 'sinatra_baseapp'
require 'test/unit'
require 'rack/test'

class SintraStaticAssetsXHTMLTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::XHTML.new    
  end
  
  def test_image_tag_closes
    get '/image_tag'
    assert last_response.ok?
    assert_equal last_response.body, "<img src=\"/images/foo.jpg\"/>"
  end

  def test_link_tag_closes
    get '/link_tag'
    assert last_response.ok?
    assert_equal last_response.body,
      "<link charset=\"utf-8\" href=\"/stylesheets/winter.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\"/>"
  end
  
end
