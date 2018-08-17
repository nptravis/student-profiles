class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_number
      t.string :section
      t.string :teacher
    end
  end
end
