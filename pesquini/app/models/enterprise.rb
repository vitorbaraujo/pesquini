# File: enterprise.rb
# Purpose: File that implements logic for Enterprise class
# License: LGPL. No copyright

class Enterprise < ActiveRecord::Base

  has_many :sanctions
  has_many :payments
  validates_uniqueness_of :cnpj

  scope :featured_sanctions, ->(number=nil){number ? order('sanctions_count DESC').limit(number) :order('sanctions_count DESC')}
  scope :featured_payments, -> (number=nil){number ? order('payments_sum DESC').limit(number) :order('payments_sum DESC')}

  # name: last_sanction
  # explanation: Picks the last sanction from a enterprise
  # parameters:
  #- none
  # return: Last sanction
  def last_sanction
    sanction = self.sanctions.last
    if !(sanction.nil?)
      self.sanctions.each do |a_sanction|
        if a_sanction.initial_date > sanction.initial_date
          sanction = a_sanction
        else
          # Nothing to do
        end
      end
    else
      # Nothing to do
    end
    return sanction
  end

  # name: last_payment
  # explanation: Picks the last payment from a enterprise
  # parameters:
  #- none
  # return: Last payment
  def last_payment
    payment = self.payments.last
    if !(payment.nil?)
      self.payments.each do |a_payment|
        if a_payment.sign_date > payment.sign_date
          payment = a_payment
        else
          # Nothing to do
        end
      end
    else
      # Nothing to do
    end
    return payment
  end

  # name: payment_after_sanction?
  # explanation: Checks if there were any payment after the last sanction from
  # a enterprise
  # parameters:
  #- none
  # return: True if there was any payment after or false otherwise.
  def payment_after_sanction?
    sanction = last_sanction
    payment = last_payment
    result_of_operation = nil
    if(sanction && payment)
      if payment.sign_date < sanction.initial_date
        result_of_operation = true
      else
        result_of_operation = false
      end
    end
    return result_of_operation
  end

  # name: refresh!
  # explanation: Reloads the object from Enterprise class to update changes
  # parameters:
  #-none
  # return: Enterprise
  def refresh!
    enterprise = Enterprise.find_by_cnpj(self.cnpj)
    return enterprise
  end

  # name: self.enterprise_poition
  # explanation: Finds a enterprise in the ranking of sanctions
  # parameters:
  #- enterprise: Object from Enterprise class
  # return: Position in ranking
  def self.enterprise_position(enterprise)
      orderedSanc = self.featured_sanctions
      groupedSanc = orderedSanc.uniq.group_by(&:sanctions_count).to_a

      groupedSanc.each_with_index do |all_sanctions,index|
        if all_sanctions[0] == enterprise.sanctions_count
          position = index + 1
          return position
        else
          # Do nothing
        end
      end
  end

  # name: self.most_sanctioned_ranking
  # explanation: Creates ranking for most sanctioned enterprises
  # parameters:
  #- none
  # return: Ranking
  def self.most_sanctioned_ranking
    enterprise_group = []
    enterprise_group_count = []
    @enterprise_group_array = []
    enterprises_sorted = Enterprise.all.sort_by{|enterprise| enterprise.sanctions_count}
    reversed_by_sanctions = enterprises_sorted.uniq.group_by(&:sanctions_count).to_a.reverse

    reversed_by_sanctions.each do |index|
      enterprise_group << index[0]
      enterprise_group_count << index[1].count
    end

      @enterprise_group_array << enterprise_group
      @enterprise_group_array << enterprise_group_count
      return @enterprise_group_array
  end

end
