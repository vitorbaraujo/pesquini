class CreateSanctionTypes < ActiveRecord::Migration 
	def change
		create_table :sanctiontype do |t|
			t.string :type
			t.string :legal_foundation
			t.string :foundation_description
		end
	end
end