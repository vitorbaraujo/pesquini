class Enterprise < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :cnpj

  scope :featured, ->(number=nil){number ? order('sanctions_count DESC').limit(number) :order('sanctions_count DESC')}

  def refresh!
    e = Enterprise.find_by_cnpj(self.cnpj)
  end
end
