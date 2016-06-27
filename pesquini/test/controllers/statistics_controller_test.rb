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

    test "should get template for most_paymented_ranking" do
        get :most_paymented_ranking

        assert_template :most_paymented_ranking
    end

    test "should get enterprise_group_ranking" do
        get :enterprise_group_ranking

        assert :success
    end

    test "should get template enterprise_group_ranking" do
        get :enterprise_group_ranking

        assert_template :enterprise_group_ranking
    end

    test "should get sanction_by_state_graph" do
        get :sanction_by_state_graph

        assert :success
    end

    test "should get template sanction_by_state_graph" do
        get :sanction_by_state_graph

        assert_template :sanction_by_state_graph
    end

    test "should get sanction_by_type_graph" do
        get :sanction_by_type_graph

        assert :success
    end

    test "should get template sanction_by_type_graph" do
        get :sanction_by_type_graph

        assert_template :sanction_by_type_graph
    end

end
