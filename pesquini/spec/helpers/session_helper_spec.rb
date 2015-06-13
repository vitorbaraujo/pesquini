require 'rails_helper'
  
include SessionsHelper

RSpec.describe SessionsHelper, :type => :helper do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe '#current_user?' do
    context 'compared with @user' do
      it 'must return true' do
        expect(current_user).to eq(@user)
      end
    end
  end
end