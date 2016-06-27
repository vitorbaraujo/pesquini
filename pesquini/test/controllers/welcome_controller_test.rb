class WelcomeControllerTest < ActionController::TestCase

    test "should get index" do
        get :index

        assert :success
    end

    test "should get template for index" do
        get :index

        assert_template :index
    end
    
end
