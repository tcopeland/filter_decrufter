# TODO just declare rails a dependency and require actionpack and activesupport here?
class Rails
  def self.application
    Rails.new
  end
  def eager_load!
    load 'integration/another_fake_controller.rb'
  end
end

module MyMethods
  def before_action(*args)
  end
end

module ActionController
  class Base
    extend MyMethods
    def self.action_methods
      my_action_methods
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
class NilClass
  def present?
    false
  end
end

class ApplicationController < ActionController::Base
end
