require File.dirname(__FILE__) + '/test_helper'

class SinatraRDiscountTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def rdiscount_app(&block)
    mock_app {
      set :views, File.dirname(__FILE__) + '/views'      
      helpers Sinatra::RDiscount
      set :show_exceptions, false
      get '/', &block
    }
    get '/'
  end
  
  def test_renders_inline_strings
    rdiscount_app { rdiscount 'hello world' }
    assert last_response.ok?
    assert_equal "<p>hello world</p>\n", last_response.body
  end
  
  def test_renders_inline_erb_string
    rdiscount_app { rdiscount '{%= 1 + 1 %}' }
    assert last_response.ok?
    assert_equal "<p>2</p>\n", last_response.body
  end

  def test_renders_files_in_views_path
    rdiscount_app { rdiscount :hello }
    assert last_response.ok?
    assert_equal "<h1>hello world</h1>\n", last_response.body
  end
  
  def test_takes_locals_option
    rdiscount_app {
      locals = {:foo => 'Bar'}
      rdiscount "{%= foo %}", :locals => locals
    }
    assert last_response.ok?
    assert_equal "<p>Bar</p>\n", last_response.body
  end

  def test_renders_with_inline_layouts
    rdiscount_app {
      rdiscount 'Sparta', :layout => 'THIS. IS. <%= yield.upcase %>' 
    }
    assert last_response.ok?
    assert_equal "THIS. IS. <P>SPARTA</P>\n", last_response.body
  end

  def test_renders_with_file_layouts
    rdiscount_app {
      rdiscount 'hello world', :layout => :layout2
    }
    assert last_response.ok?
    assert_equal "erb layout\n<p>hello world</p>\n\n", last_response.body
  end

  def test_renders_erb_with_blocks
    mock_app {
      set :views, File.dirname(__FILE__) + '/views'      
      helpers Sinatra::RDiscount
      
      def container
        yield
      end
      def is;
        "THIS. IS. SPARTA!"
      end
      
      get '/' do
        rdiscount '{% container do %} {%= is %} {% end %}'
      end
    }
    
    get '/'
    assert last_response.ok?
    assert_equal "<p> THIS. IS. SPARTA! </p>\n", last_response.body
  end
  
  def test_raises_error_if_template_not_found
    mock_app {
      set :views, File.dirname(__FILE__) + '/views'      
      helpers Sinatra::RDiscount
      set :show_exceptions, false
      
      get('/') { rdiscount :no_such_template }
    }
    assert_raise(Errno::ENOENT) { get('/') }
  end
end
