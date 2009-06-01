# Sinatra Extension: StaticAssets  

Gem *sinatra-static-assets* implements the following helpers methods:

* `image_tag`
* `stylesheet_link_tag`
* `javascript_script_tag`
* `link_tag`

To install it, run:

    sudo gem install wbzyl-sinatra-static-assets -s http://gems.github.com

All these methods are simple wrappers around the `url_for` method 
from the [sinatra-url-for](http://github.com/emk/sinatra-url-for/) gem.

## When will you need it?

Whenever you use the
[Passenger module for Apache2](http://www.modrails.com/documentation/Users%20guide%20Apache.html#deploying_rack_to_sub_uri)
or use `Rack::URLMap` to dispatch an application to
sub URI.

Example: Suppose that we already have a virtual host `hitch.local`
and two Sinatra applications that live in
`/home/me/www/summer` and `/home/me/www/winter` 
directories, respectively.
We want our Sinatra applications to be accessible from 
the following sub URI: 

    http://hitch.local/summer 

and

    http://hitch.local/winter

To configure Apache2 and Passenger to serve our applications
we need to create a new configuration file with the following content:

    <VirtualHost *:80>
      ServerName hitch.local
      DocumentRoot /srv/www/hitch.local
      
      RackBaseURI /summer
      RackBaseURI /winter
    </VirtualHost>

and a link to the applications directories in `/srv/www/hitch.local`:

    ln -s /home/me/www/summer/public /srv/www/hitch.local/summer
    ln -s /home/me/www/winter/public /srv/www/hitch.local/winter

After restarting an Apache2 server and visiting, for example, the first 
application at `http://hitch.local/summer` we see that links to
images, stylesheets and javascripts are broken.

The hitch here is that in Sinatra applications we usually refer to
images/stylesheets/javascripts with absolute URI:

    /images/tatry1.jpg    /stylesheets/app.css    /javascripts/app.js

That setup **works** whenever we are running applications locally.
The absolute URI above tells a browser to request images 
(stylesheets and javascripts) from:

    http://localhost:4567/images/tatry1.jpg

which in turn, tells a server to send a file:

    /home/me/www/summer/public/images/tatry1.jpg

The `public` directory is the default directory where static files
should be served from.
So, the `/images/tatry1.jpg` picture will be there and will be served
unless we had changed that default directory.

But these absolute URIs do not work when, for example,
the *summer* application is dispatched to `/summer` sub URI.
As a result the images are at:

    http://hitch.local/summer/images/tatry1.jpg

but we request them from: 

    http://hitch.local/images/tatry1.jpg

And this **does not work** because there is no application 
dispatched to *images* sub URI.

The recommended way to deal with an absolute URI 
is to use a helper method that automatically converts
`/images/tatry1.jpg` to `/summer/images/tatry1.jpg`
for application dispatched to `/summer` sub URI. 

In the above example you can simply remove the `<img>` 
HTML tag and replace it with a Ruby inline code like this: 

    <%= image_tag("/images/tatry1.jpg", :alt => "Błyszcz, 2159 m") %>

See also, [How to fix broken images/CSS/JavaScript URIs in sub-URI 
deployments](http://www.modrails.com/documentation/Users%20guide%20Apache.html#sub_uri_deployment_uri_fix)

## Usage examples

In HTML `<link>` and `<img>` tags have no end tag.
In XHTML, on the contrary, these tags must be properly closed.

We can choose the appropriate behaviour with *closed* option:

    image_tag "/images/tatry1.jpg", :alt => "Błyszcz, 2159 m", :closed => true

The default value of *closed* option is `false`.

    stylesheet_link_tag "/stylesheets/screen.css", "/stylesheets/summer.css", :media => "projection"
    javascript_script_tag "/javascripts/jquery.js", "/javascripts/summer.js", :charset => "iso-8859-2"
    link_to "Tatry Mountains Rescue Team", "/topr"

In order to use include the following in a Sinatra application: 

    gem 'wbzyl-sinatra-static-assets'
    require 'sinatra/static_assets'

Or, if subclassing `Sinatra::Base`, include helpers manually:

    gem 'wbzyl-sinatra-static-assets'
    require 'sinatra/static_assets'
      
    class Summer < Sinatra::Base
      helpers Sinatra::StaticAssets
      # ...
    end

## Dispatching reusable Sinatra applications

With the latest version of Sinatra it is possible to build
reusable Sinatra applications. This means that multiple Sinatra applications
can be run in isolation and co-exist peacefully with other Rack
based applications. Subclassing `Sinatra::Base` creates such a
reusable application.

The `example` directory contains two reusable Sinatra applications:
*rsummer*, *rwinter* and a rackup file `rconfig.ru` which
dispatches these applications to `/summer` and `/rsummer` sub URI.

    require 'rsummer/summer'
    require 'rwinter/winter'
    
    map '/summer' do
      run Sinatra::Summer.new
    end
      
    map '/winter' do
      run Sinatra::Winter.new
    end

This rackup file could be used to deploy to virtual host's root:

    <VirtualHost *:80>
        ServerName hitch.local
        DocumentRoot /srv/www/hitch.local
    </VirtualHost>

To this end, create directories required by Passenger:

    mkdir /srv/www/hitch.local/{public,tmp}

and move `config.ru` into `/srv/www/hitch.local`.

With everything in place, after restarting Apache2, 
the applications are accessible from the

    http://hitch.local/summer    

and

    http://hitch.local/winter

respectively.

## Miscellaneous stuff

1. The `examples` directory contains *summer* and *winter* applications.

2. In order to create a virual host add the following to */etc/hosts/*: 

    127.0.0.1       localhost.localdomain localhost hitch.local

3. TODO: write tests
