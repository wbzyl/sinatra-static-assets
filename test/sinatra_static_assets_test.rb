require 'sinatra_app'
require 'test/unit'
require 'rack/test'

set :environment, :test

class SintraStaticAssetsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_url_for_returns_absolute_paths_and_full_urls
    get '/url_for', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body,  <<EOD
/bar/
/bar/foo
http://example.org/bar/foo
EOD
  end
  
  def test_image_tag_returns_absolute_paths_and_full_urls
    get '/image_tag', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body,  <<EOD
<img alt="[foo image]" src="/bar/images/foo.jpg">
EOD
  end

  
end

__END__

stylesheet_link_tag "/stylesheets/screen.css", "/stylesheets/summer.css", :media => "projection"
javascript_script_tag "/javascripts/jquery.js", "/javascripts/summer.js", :charset => "iso-8859-2"
link_to "Tatry Mountains Rescue Team", "/topr"
