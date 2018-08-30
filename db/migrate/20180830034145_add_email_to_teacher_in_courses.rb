class AddEmailToTeacherInCourses < ActiveRecord::Migration[5.1]
  def change
  	rename_column :courses, :teacher, :teacher_email
  end
end
