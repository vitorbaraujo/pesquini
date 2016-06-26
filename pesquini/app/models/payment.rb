# File: payment.rb
# Purpose: File that implements payment methods.
# License : LGPL. No copyright

#This class implements the logic of payment.

class Payment < ActiveRecord::Base

  belongs_to :enterprise

  validates_uniqueness_of :process_number

  # name: refresh!
  # explanation: This method find payment by process number.
  # parameters:
  # - none
  # return: A instance of Payment.

  def refresh!
    payment = Payment.find_by_process_number(self.process_number)

    assert(payment.kind_of?(Payment))

    return payment
  end
  
end