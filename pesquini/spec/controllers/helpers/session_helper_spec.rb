require 'rails_helper'
  
  include SessionsHelper
  RSpec.describe SessionsHelper, :type => :helper do
  before do
    @user = User.create(login: "teste_user", password:"password_teste")
    @aux = User.create(login: "teste_123", password:"password_teste")
  end

  describe '#current_user?' do
    context 'compared with @user' do
      it 'must return true' do
        @user.login = "teste_user"
        @user.should be_valid
      end
    end
  end
end