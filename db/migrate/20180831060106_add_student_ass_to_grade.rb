class AddStudentAssToGrade < ActiveRecord::Migration[5.1]
  def change
  	rename_column :grades, :section_id, :student_id 
  end
end
