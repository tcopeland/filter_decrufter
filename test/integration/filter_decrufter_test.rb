require "test_helper"
require 'integration_test_helper'

class FilterDecrufterTest < MiniTest::Test

  def test_finds_problems
    $stdout.expects(:puts).with("AnotherFakeController before_action 'foo' has an :only constraint with a non-existent action name 'bar'")
    FilterDecrufter::Checker.new.check
  end

end
