class State < ActiveRecord::Base
  include Assertions

  has_many :sanctions
  validates_uniqueness_of :abbreviation

  def update_state
      actual_sanction = State.find_by_abbreviation( self.abbreviation )
      assert_object_is_not_null( actual_sanction )
      
    return actual_sanction
  end

  def self.all_states
    states = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR",
     "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC",
     "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]
      assert_object_is_not_null( states )

    return states

  end

end
