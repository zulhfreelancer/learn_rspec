class AddDefaultValueToContactHidden < ActiveRecord::Migration
  
	def up
		change_column_default :contacts, :hidden, false
	end

	def down
		change_column_default :contacts, :hidden, nil
	end

end
