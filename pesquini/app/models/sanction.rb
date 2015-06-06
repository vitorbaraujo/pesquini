class Sanction < ActiveRecord::Base

  belongs_to :enterprise, counter_cache: true
  belongs_to :sanction_type
  belongs_to :state

  validates_uniqueness_of :process_number

  scope :by_year, lambda { |year| where('extract(year from initial_date) = ?', year) }


  def refresh!
    s = Sanction.find_by_process_number(self.process_number)
  end

end	