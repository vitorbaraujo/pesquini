require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do 

  user = User.new(login: 'sanjaninha', password: 'sanjana123')
  user.save

  subject { post :create, :session => {:login => 'sanjana', :password => 'sanjana123'}}
  describe   "GET" do 
    describe '#create' do
      it "should log in user with correct login and password" do 
        post :create, :session => {:login =>"sanjaninha", :password => 'sanjana123'}
        expect(response).to redirect_to(root_path)
      end

      it "should redirect log in page if user does not exist" do 
        post :create, :session => {:login => 'anything', :password => 'shit'}
        expect(response).to render_template("/new")
      end
    end
  end
end