require 'spec_helper'
require 'rails_helper'

describe Enterprise do

  before do
    @enterprise = Enterprise.new
    @enterprise.cnpj = "555"
    @enterprise.corporate_name = "Samsung"
    @enterprise.save
  end
  
  subject { @enterprise }
    it { should respond_to(:cnpj) }
    it { should respond_to(:corporate_name) }
  it { should be_valid }

  describe "uniqueness validation of cnpj" do
    
    describe "unique cnpj" do
      it "should be_valid" do
        uniqueness_enterprise = Enterprise.new
        uniqueness_enterprise.cnpj = "1234" 
        expect(uniqueness_enterprise).to be_valid
      end
    end
    
  describe "duplicated cnpj" do
      it "should not be_valid" do
        duplicated_enterprise = Enterprise.new
        duplicated_enterprise.cnpj = "555"
        expect(duplicated_enterprise).not_to be_valid
      end
    end
  
  end   
end