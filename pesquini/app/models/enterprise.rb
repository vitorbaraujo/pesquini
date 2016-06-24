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
      self.sanctions.each do |s|
        sanction = s if s.initial_date > sanction.initial_date
      end
    else
      # Nothing to do
    end
    sanction
  end

  # name: last_payment
  # explanation: Picks the last payment from a enterprise
  # parameters:
  #- none
  # return: Last payment
  def last_payment
    payment = self.payments.last
    if !(payment.nil?)
      self.payments.each do |f|
        if f.sign_date > payment.sign_date
          payment = f
        else
          # Nothing to do
        end
      end
    else
      # Nothing to do
    end
    payment
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
    if(sanction && payment)
      if payment.sign_date < sanction.initial_date
        true
      else
        false
      end
    end
  end

  # name: refresh!
  # explanation: Reloads the object from Enterprise class to update changes
  # parameters:
  #-none
  # return: Enterprise
  def refresh!
    e = Enterprise.find_by_cnpj(self.cnpj)
  end

  # name: self.enterprise_poition
  # explanation: Finds a enterprise in the ranking of sanctions
  # parameters:
  #- enterprise: Object from Enterprise class
  # return: Position in ranking
  def self.enterprise_position(enterprise)
      orderedSanc = self.featured_sanctions
      groupedSanc = orderedSanc.uniq.group_by(&:sanctions_count).to_a

      groupedSanc.each_with_index do |k,index|
        if k[0] == enterprise.sanctions_count
          return index + 1
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
    a = Enterprise.all.sort_by{|x| x.sanctions_count}
    b = a.uniq.group_by(&:sanctions_count).to_a.reverse

    b.each do |k|
      enterprise_group << k[0]
      enterprise_group_count << k[1].count
    end

      @enterprise_group_array << enterprise_group
      @enterprise_group_array << enterprise_group_count
      @enterprise_group_array
  end

end
