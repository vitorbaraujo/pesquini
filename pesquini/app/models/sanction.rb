class Sanction < ActiveRecord::Base

  belongs_to :enterprise
  belongs_to :sanction_type
  belongs_to :state

  validates_uniqueness_of :process_number

  def refresh!
    s = Sanction.find_by_process_number(self.process_number)
    self.attributes.each do |attr_name, attr_value|
      self.attr_name = s.attr_name
    end
  end

end	