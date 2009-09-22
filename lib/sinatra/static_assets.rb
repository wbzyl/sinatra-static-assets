require 'sinatra/base'
require 'sinatra/url_for'

module Sinatra
  module StaticAssets
    # In HTML <link> and <img> tags have no end tag.
    # In XHTML, on the contrary, these tags must be properly closed.
    #
    # We can choose the appropriate behaviour with +closed+ option:
    #
    #   image_tag "/images/foo.png", :alt => "Foo itself", :closed => true
    #
    # The default value of +closed+ option is +false+.
    #
    def image_tag(source, options = {})
      closed = options.delete(:closed)
      options[:src] = url_for(source)
      tag("img", options, closed)
    end

    def stylesheet_link_tag(*sources)
      list, options = extract_options(sources)
      closed = options.delete(:closed)
      list.collect { |source| stylesheet_tag(source, options, closed) }.join("\n")
    end

    def javascript_script_tag(*sources)
      list, options = extract_options(sources)
      list.collect { |source| javascript_tag(source, options) }.join("\n")
    end
    
    def link_to(desc, url)
      "<a href='#{url_for(url)}'>#{desc}</a>"
    end
    
    private
    
    def tag(name, options = {}, closed = false)
      "<#{name}#{tag_options(options) if options}#{closed ? " />" : ">"}"
    end
    
    def tag_options(options)
      unless options.empty?
        attrs = []
        attrs = options.map { |key, value| %(#{key}="#{value}") }
        " #{attrs.sort * ' '}" unless attrs.empty?
      end
    end
    
    def stylesheet_tag(source, options, closed = false)
      tag("link", { :type => "text/css",
            :charset => "utf-8", :media => "screen", :rel => "stylesheet",
            :href => url_for(source) }.merge(options), closed)
    end
    
    def javascript_tag(source, options)
      tag("script", { :type => "text/javascript", :charset => "utf-8",
            :src => url_for(source) }.merge(options), false) + "</script>"
    end
    
    def extract_options(a)
      opts = a.last.is_a?(::Hash) ? a.pop : {}
      [a, opts]  
    end

  end

  helpers StaticAssets
end
