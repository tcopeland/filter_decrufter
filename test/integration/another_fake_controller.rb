class AnotherFakeController < ApplicationController

  def self.action_methods
    [:foo]
  end

  before_action :foo, :only => [:bar]

  def foo
  end

end
