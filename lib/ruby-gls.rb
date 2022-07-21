require 'ruby-gls/version'
require 'ruby-gls/configuration'
require 'ruby-gls/tracking'
require 'ruby-gls/client'
require 'ruby-gls/connection'
require 'ruby-gls/url'

class RubyGLS
  extend Tracking
  
  RubyGLS.configure
end