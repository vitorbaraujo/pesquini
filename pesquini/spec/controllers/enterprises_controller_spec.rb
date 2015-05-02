require 'rails_helper'

RSpec.describe EnterprisesController, :type => :controller do 
  describe "GET" do 
    describe '#graphics' do
      it "select_graphics" do
        get :graphics
        expect(response).to have_http_status(:success)
      end
    end    
    describe '#index' do
      it "should work" do 
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end