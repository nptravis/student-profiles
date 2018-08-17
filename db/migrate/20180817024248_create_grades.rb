class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :grades do |t|
      t.integer :course_id
      t.integer :standard_id
      t.integer :student_id
      t.string :grade
      t.string :semester
    end
  end
end
