class AddSemesterToGrades < ActiveRecord::Migration[5.1]
  def change
  	add_column :grades, :semester, :string
  end
end
