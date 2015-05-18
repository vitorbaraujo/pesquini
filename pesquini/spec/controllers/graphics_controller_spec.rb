require 'rails_helper'

RSpec.describe GraphicsController, :type => :controller do 
  describe "GET" do 
    describe '#index' do
      it "graphics/index" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end    
  end
end