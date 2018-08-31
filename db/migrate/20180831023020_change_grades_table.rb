class ChangeGradesTable < ActiveRecord::Migration[5.1]
  def change
  	rename_column :grades, :course_id, :section_id
  	remove_column :grades, :student_id, :integer
  end
end
