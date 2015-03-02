require "test_helper"

class HitTest < MiniTest::Test

  def test_should_be_able_to_test_for_action_method_inclusion
    h = FilterDecrufter::Hit.new(MyFakeController, :before_action, {}, :only)
    assert h.actions_include?(:foo)
  end

end
