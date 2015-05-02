class Enterprise < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :cnpj

	def refresh!
    e = Enterprise.find_by_cnpj(self.cnpj)
    self.attributes.each do |attr_name, attr_value|
      unless attr_name.include?("corporate_name")
        self.attr_name = c.attr_name
      end
    end
    self.corporate_name = e.corporate_name unless e.company_name.nil?
	end

end
