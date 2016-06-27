class StatisticsControllerTest < ActionController::TestCase

    test "should get index" do
        get :index

        assert :success
    end

    test "should get template for index" do
        get :index

        assert_template :index
    end

    test "should get most most_sanctioned_ranking" do
        get :most_sanctioned_ranking

        assert :success
    end

    test "should get template for most_sanctioned_ranking" do
        get :most_sanctioned_ranking

        assert_template :most_sanctioned_ranking
    end

    test "should get most_paymented_ranking" do
        get :most_paymented_ranking

        assert :success
    end

end
