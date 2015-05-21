class Enterprise < ActiveRecord::Base
  
  has_many :sanctions
  validates_uniqueness_of :cnpj

  scope :featured,  -> { order('sanctions_count DESC') .limit(10)}

	def refresh!
        e = Enterprise.find_by_cnpj(self.cnpj)
	end
end
