class SessionsControllerTest < ActionController::TestCase

    test "should get new" do
        get :new

        assert :success
    end

    test "should get template for new" do
        get :new

        assert_template :new
    end

end
