require 'rails_helper'

RSpec.describe StatisticsController, :type => :controller do 
  describe "GET" do 
    
    describe '#sanction_by_state_graph' do
      it "should work" do
        get :sanction_by_state_graph
        expect(response).to have_http_status(:success)
      end
    end

    describe '#index' do
      it "should work" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end    

    describe '#most_sanctioned_ranking' do
      it "should work" do
        get :most_sanctioned_ranking
        expect(response).to have_http_status(:success)
      end
    end

    describe '#sanction_by_type_graph' do
      it "should work" do
        get :sanction_by_type_graph
        expect(response).to have_http_status(:success)
      end
    end
  end
end
