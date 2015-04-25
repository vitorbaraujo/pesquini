class CreateEnterprises < ActiveRecord::Migration 
	def change
		create_table :enterprises do |t|
			t.string :cnpj
			t.string :corporate_name
			t.integer :sanction_organ
		end
	end
end