class CreateEnterprises < ActiveRecord::Migration 
	def change
		create_table :enterprises do |t|
			t.string :cnpj
			t.string :corporate_name
			t.string :sanctioning_organ
			t.integer :amount_sanction
			t.string :ranking_position
			t.string :hiring_after_sanction
		end
	end
end