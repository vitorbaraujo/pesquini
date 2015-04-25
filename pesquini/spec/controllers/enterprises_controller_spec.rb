require 'rails_helper'

RSpec.describe EnterprisesController, :type => :controller do 
  describe "GET" do 
    describe '#index' do
      it "should work" do 
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end