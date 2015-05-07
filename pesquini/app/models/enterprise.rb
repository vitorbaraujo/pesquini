class Enterprise < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :cnpj

	def refresh!
        e = Enterprise.find_by_cnpj(self.cnpj)
	end
end
