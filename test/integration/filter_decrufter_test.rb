require "test_helper"

class Rails
  def self.application
    Rails.new
  end
  def eager_load!
    load 'integration/another_fake_controller.rb'
  end
end

module ActionController
  class Base
    def self.before_action(*args)
    end
  end
end

class Hash
  def present?
    keys.any?
  end
end

class Array
  def present?
    !empty?
  end
end

class ApplicationController < ActionController::Base
end

class FilterDecrufterTest < MiniTest::Test

  def test_finds_problems
    FilterDecrufter::Checker.new.check
  end

end
