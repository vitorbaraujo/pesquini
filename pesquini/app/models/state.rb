#  File: state
#  Purpose: Implementation of state model
#  License : LGPL. No copyright.

# This controller represents states in the Brazilian territory


class State < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :abbreviation

# name: update_state
# explanation: this method refreshes a given state.
# parameters:
# - non
# return: actual_sanction

  def update_state
      actual_sanction = State.find_by_abbreviation( self.abbreviation )
      assert(!actual_sanction.nil?)
      
    actual_sanction = State.find_by_abbreviation( self.abbreviation )

>>>>>>> a09cae6aa56a1e811d230196ca1ac7a066508bc1
    return actual_sanction
  end

# name: self.all_states
# explanation: this method prepares all state's abbreviations.
# parameters:
# - non
# return: states

  def self.all_states
    states = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR",
     "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC",
     "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]

     assert(!states.nil?)
>>>>>>> a09cae6aa56a1e811d230196ca1ac7a066508bc1

     return states

  end

end
