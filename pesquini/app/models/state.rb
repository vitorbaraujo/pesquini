class State < ActiveRecord::Base
  has_many :sanctions
  validates_uniqueness_of :abbreviation

  def refresh!
    s = State.find_by_abbreviation(self.abbreviation)
  end
end