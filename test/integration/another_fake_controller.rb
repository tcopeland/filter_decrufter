class AnotherFakeController < ApplicationController

  before_action :foo, :only => [:bar]

  def foo
  end

  def self.my_action_methods
    [:foo]
  end

end
