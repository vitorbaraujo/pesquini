class State < ActiveRecord::Base
  has_many :sanctions
  validates_uniqueness_of :abbreviation

  def refresh!
    s = State.find_by_abbreviation(self.abbreviation)
    self.attributes.each do |attr_name, attr_value|
        self.attr_name = s.attr_name
    end
  end
end