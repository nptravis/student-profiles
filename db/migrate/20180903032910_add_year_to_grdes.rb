class AddYearToGrdes < ActiveRecord::Migration[5.1]
  def change
  	add_column :grades, :yearid, :integer
  end
end
