require 'rake'
require "rubygems"
require "bundler/setup"
require "minitest/autorun"
require 'mocha/setup'

require 'filter_decrufter'

class MyFakeController
  def self.action_methods
    [:foo]
  end
  def foo
  end
end