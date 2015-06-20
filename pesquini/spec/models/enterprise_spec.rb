require 'spec_helper'
require 'rails_helper'

describe Enterprise do

  before do
    @enterprise = Enterprise.new
    @sanction = Sanction.new
    @payment = Payment.new
    @enterprise.cnpj = "555"
    @enterprise.corporate_name = "Samsung"
    @enterprise.save

    @sanction.initial_date = "01/02/2010".to_date
    @sanction.enterprise_id = @enterprise.id
    @sanction.save

    @payment.sign_date = "01/02/2011".to_date
    @payment.enterprise_id = @enterprise.id
    @payment.save
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

    describe "payment_after_sanction" do
      it "should return false if have any sanction or any payment" do
        e = Enterprise.new
        expect(e.sanctions.count).to be(0)
        expect(e.payments.count).to be(0)
        expect(e.payment_after_sanction?).to be false
      end
      it "should return true if have payment after sanction" do
        # expect(@enterprise.payments.last.sign_date).to eq("01/02/2011".to_date)
        # expect(@enterprise.sanctions.last.initial_date).to eq("01/02/2010".to_date)
        expect(@enterprise.payment_after_sanction?).to be true
      end

      it "should return false there is no payment after sanction" do
        # expect(@enterprise.payments.last.sign_date).to eq("01/02/2011".to_date)
        # expect(@enterprise.sanctions.last.initial_date).to eq("01/02/2010".to_date)
        @sanction.initial_date = "01/02/2015".to_date
        @sanction.save
        expect(@enterprise.payment_after_sanction?).to be false
      end

    end
  end   
end