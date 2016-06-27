class UserTest < ActiveSupport::TestCase

  test "should not create user with 4 character login" do
    user = User.new(login: "quat", password: "omelete1", password_confirmation: "omelete1")

    assert_equal user.valid?, false
  end

  test "should create a user with 5 characters" do
    user = User.new(login: "quatr", password: "omelete1", password_confirmation: "omelete1")

    assert user.valid?
  end

  test "should create a user with 6 characters" do
    user = User.new(login: "quatro", password: "omelete1", password_confirmation: "omelete1")

    assert user.valid?
  end

  test "should not create user with 51 character login" do
    string = "a"*51
    user = User.new(login: string, password: "omelete1", password_confirmation: "omelete1")

    assert_equal user.valid?, false
  end

  test "should create user with 50 character login" do
    string = "a"*50
    user = User.new(login: string, password: "omelete1", password_confirmation: "omelete1")

    assert user.valid?
  end

  test "should create user with 49 character login" do
    string = "a"*49
    user = User.new(login: string, password: "omelete1", password_confirmation: "omelete1")

    assert user.valid?
  end

  test "should not create user with 7 character password" do
    user = User.new(login: "jessicacris", password: "1234567", password_confirmation: "1234567")

    assert_equal user.valid?, false
  end

  test "should create user with 8 character password" do
    user = User.new(login: "jessicacris", password: "12345678", password_confirmation: "12345678")

    assert user.valid?
  end

  test "should create user with 9 character password" do
    user = User.new(login: "jessicacris", password: "123456789", password_confirmation: "123456789")

    assert user.valid?
  end

  test "should not create user with blank password" do
    user = User.new(login: "jessicacris", password: "", password_confirmation: "")

    assert_equal user.valid?, false
  end

  test "should not create with two equal login" do
    user = User.new(login: "jessicacris", password: "12345678", password_confirmation: "12345678")
    user2 = User.new(login: "jessicacris", password: "12345678", password_confirmation: "12345678")
    user.save

    assert_equal user2.valid?, false
  end

  test "should not create with blank login" do
    user = User.new(login: "", password: "12345678", password_confirmation: "12345678")

    assert_equal user.valid?, false
  end

  test "should not create user with blank password_confirmation" do
    user = User.new(login: "asidjoisadj", password: "12345678", password_confirmation: "")

    assert_equal user.valid?, false
  end

end
