require 'rubygems'

# Require all Gems automatically
require 'bundler/setup'
Bundler.require

# require everything in the app folder
require_all './*.rb'

run Server
