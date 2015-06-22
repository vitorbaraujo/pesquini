require 'spec_helper'
require 'rails_helper'

describe SanctionType do

  before do
    @sanction_type = SanctionType.new
    @sanction_type.description = "Proibição - Lei Eleitoral"
    @sanction_type.save
  end

  subject {@sanction_type}
    it { should respond_to(:description) }
  it { should be_valid }

  describe "uniqueness validation of description" do
    
    describe "unique description" do
      it "should be_valid" do
        uniqueness_sanction_type = SanctionType.new
        uniqueness_sanction_type.description = "Inidoneidade - Lei de Licitações" 
        expect(uniqueness_sanction_type).to be_valid
      end
    end

   describe "duplicated description" do
        it "should not be_valid" do
        duplicated_sanction_type = SanctionType.new
        duplicated_sanction_type.description = "Proibição - Lei Eleitoral" 
        expect(duplicated_sanction_type).not_to be_valid
      end
    end
    
  end
end