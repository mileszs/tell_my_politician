# Change this to the name of your rails project, like carbonrally.
# Just use the same name as the svn repo.
PROJECT_NAME = "tell_my_politician"

throw "The project's name in environment.rb is blank" if PROJECT_NAME.empty?
throw "Project name (#{PROJECT_NAME}) must_be_like_this" unless PROJECT_NAME =~ /^[a-z_]*$/

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  # Specify gems that this application depends on.
  config.gem 'RedCloth',
             :lib => 'redcloth',
             :version => '~> 3.0.4'
  config.gem 'mislav-will_paginate',
             :lib => 'will_paginate',
             :source => 'http://gems.github.com',
             :version => '~> 2.3.6'
  config.gem 'ym4r'
  config.gem 'json'
  config.gem 'sunlight'
  config.gem 'mbleigh-acts-as-taggable-on', :source => "http://gems.github.com", :lib => "acts-as-taggable-on"
  config.gem "ambethia-smtp-tls", :lib => "smtp-tls", :source => "http://gems.github.com/"


  # Add the vendor/gems/*/lib directories to the LOAD_PATH
  config.load_paths += Dir.glob(File.join(RAILS_ROOT, 'vendor', 'gems', '*', 'lib'))

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.
  SESSION_KEY = "0559600493dfabd3999d3af734aec674"
  config.action_controller.session = {
    :session_key => "_#{PROJECT_NAME}_session",
    :secret      => SESSION_KEY
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

end
