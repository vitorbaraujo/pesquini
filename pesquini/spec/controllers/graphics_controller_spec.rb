require 'rails_helper'

RSpec.describe EnterprisesController, :type => :controller do 
  describe "GET" do 
    describe '#index' do
      it "select_graphics" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end    
  end
end