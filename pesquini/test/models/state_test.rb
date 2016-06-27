class StateTest < ActiveSupport::TestCase

  test "should not be two states with same abbreviation" do
    state1 = State.new(code: 2, name: "Estado", abbreviation: "OM")
    state1.save
    state2 = State.new(code: 3, name: "Estado2", abbreviation: "OM")

    assert_equal state2.valid?, false
  end

  test "should be able to create state" do
    state1 = State.new(code: 2, name: "Estado", abbreviation: "OMIDI")

    assert state1.save
  end

  test "should all_states hash not contain 27 items" do
    all_states = State.all_states

    assert_not_equal all_states.count, 27
  end

  test "should all_states hash contain 28 items" do
    all_states = State.all_states

    assert_equal all_states.count, 28
  end

  test "should all_states hash not contain 29 items" do
    all_states = State.all_states

    assert_not_equal all_states.count, 29
  end

  test "should all_states be not nil" do
    all_states = State.all_states

    assert_not_nil all_states
  end

end
