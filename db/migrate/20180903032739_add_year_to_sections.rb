class AddYearToSections < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :yearid, :integer
  end
end
