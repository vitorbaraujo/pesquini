class Enterprise < ActiveRecord::Base

  has_many :sanctions
  has_many :payments
  validates_uniqueness_of :cnpj

  scope :featured_sanctions, ->(number=nil){number ? order('sanctions_count DESC').limit(number) :order('sanctions_count DESC')}
  scope :featured_payments, -> (number=nil){number ? order('payments_sum DESC').limit(number) :order('payments_sum DESC')}

   def last_sanction
    sanction = self.sanctions.last
    unless sanction.nil?    
      self.sanctions.each do |s|
        sanction = s if s.initial_date > sanction.initial_date
      end
    end
    sanction
  end

  def last_payment
    payment = self.payments.last
    unless payment.nil?
      self.payments.each do |f|
        payment = f if f.sign_date > payment.sign_date
      end
    end
    payment
  end

  def payment_after_sanction?
    sanction = last_sanction
    payment = last_payment
    if sanction && payment
      sanction.initial_date > payment.sign_date
    else
      false
    end
  end

  def refresh!
    e = Enterprise.find_by_cnpj(self.cnpj)
  end
end
