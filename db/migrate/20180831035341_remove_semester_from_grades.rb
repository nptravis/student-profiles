class RemoveSemesterFromGrades < ActiveRecord::Migration[5.1]
  def change
  	remove_column :grades, :semester
  end
end
