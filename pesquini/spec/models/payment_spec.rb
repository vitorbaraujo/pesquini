require 'spec_helper'
require 'rails_helper'

describe Payment do

  before do
    @payment = Payment.new
    @payment.process_number = "1"
    @payment.save
  end

  subject {@payment}
    it { should respond_to(:process_number) }
  it { should be_valid }

  describe "uniqueness validation of process_number" do
    
    describe "unique process_number" do
      it "should be_valid" do
        uniqueness_payment = Payment.new
        uniqueness_payment.process_number = "7" 
        expect(uniqueness_payment).to be_valid
      end
    end
   describe "duplicated process_number" do
        it "should not be_valid" do
        duplicated_payment = Payment.new
        duplicated_payment.process_number = "1" 
        expect(duplicated_payment).not_to be_valid
      end
    end
    
  end
end