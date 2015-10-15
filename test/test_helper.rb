require "rubygems"
require "bundler"

gem 'minitest'
require "minitest/autorun"

Bundler.setup
Bundler.require :default, :test

require 'puma'
require 'mocha/mini_test'

require 'rack/mock'

require 'action_cable'
ActiveSupport.test_order = :sorted

# Require all the stubs and models
Dir[File.dirname(__FILE__) + '/stubs/*.rb'].each {|file| require file }

Celluloid.logger = Logger.new(StringIO.new)

class ActionCable::TestCase < ActiveSupport::TestCase
  def run_in_eventmachine
    EM.run do
      yield

      EM::Timer.new(0.1) { EM.stop }
    end
  end
end
