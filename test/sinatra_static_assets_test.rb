require './test/test_helper'
require './test/sinatra_app'
require 'test/unit'
require 'rack/test'
require 'sinatra/static_assets'

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
  
  def test_asset_url_for_returns_timestamp_only_on_existing_paths
    get '/asset_url_for', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body, <<EOD
/bar/test.css?#{asset_timestamp('test.css')}
http://example.org/test.css
EOD
  end

  def test_image_tag_returns_sub_uri
    get '/image_tag', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body,  <<EOD
<img alt="[foo image]" src="/bar/images/foo.jpg">
EOD
  end

  def test_stylesheet_link_tag_returns_sub_uri
    get '/stylesheet_link_tag', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body,  <<EOD
<link charset="utf-8" href="/bar/stylesheets/winter.css" media="projection" rel="stylesheet" type="text/css">
<link charset="utf-8" href="/bar/stylesheets/summer.css" media="projection" rel="stylesheet" type="text/css">
<link charset="utf-8" href="/bar/test.css?#{asset_timestamp('test.css')}" media="projection" rel="stylesheet" type="text/css">
EOD
  end

  def test_javascript_script_tag_returns_sub_uri
    get '/javascript_script_tag', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body,  <<EOD
<script charset="iso-8859-2" src="/bar/javascripts/summer.js" type="text/javascript"></script>
EOD
  end

  def test_link_to_tag_returns_sub_uri
    get '/link_to_tag', {}, 'SCRIPT_NAME' => '/bar'
    assert last_response.ok?
    assert_equal last_response.body,  <<EOD
<a href="/bar/topr">Tatry Mountains Rescue Team</a>
EOD
  end

end
