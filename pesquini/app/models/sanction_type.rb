class SanctionType < ActiveRecord::Base
  has_many :sanctions
  validates_uniqueness_of :description

  def refresh!
    s = SanctionType.find_by_type(self.type)
    self.attributes.each do |attr_name, attr_value|
        self.attr_name = s.attr_name
    end
  end
end
