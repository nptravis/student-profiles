class AddPercentToTradGrades < ActiveRecord::Migration[5.1]
  def change
  	add_column :trad_grades, :percent, :float
  end
end
