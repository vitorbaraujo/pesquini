class Payment < ActiveRecord::Base

  belongs_to :enterprise, counter_cache: true

  validates_uniqueness_of :process_number

  def refresh!
    p = Payment.find_by_process_number(self.process_number)
  end


end