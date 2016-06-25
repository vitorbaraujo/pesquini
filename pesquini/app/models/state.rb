class State < ActiveRecord::Base
  has_many :sanctions
  validates_uniqueness_of :abbreviation

  def refresh!
      actual_sanction = State.find_by_abbreviation( self.abbreviation )
      
      return actual_sanction
  end

  def self.all_states
    states = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR",
     "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC",
     "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]
    
    return states
  end

end
