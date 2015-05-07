class SanctionType < ActiveRecord::Base
  has_many :sanctions
  validates_uniqueness_of :description

  def refresh!
    s = SanctionType.find_by_description(self.description)
  end
end
