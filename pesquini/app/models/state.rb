class State < ActiveRecord::Base
  has_many :sanctions
  validates_uniqueness_of :abbreviation

  def id
    self.id
  end

  def refresh!
    s = State.find_by_abbreviation(self.abbreviation)
  end
end