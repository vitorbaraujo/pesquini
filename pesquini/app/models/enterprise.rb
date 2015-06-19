class Enterprise < ActiveRecord::Base

  has_many :sanctions
  has_many :payments
  validates_uniqueness_of :cnpj

  scope :featured,  -> { order('payments_sum DESC') }

  def refresh!
    e = Enterprise.find_by_cnpj(self.cnpj)
  end
end
