class CreateSection < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
    	t.integer :course_id
    	t.integer :student_id
    	t.string :course_number
    	t.string :course_name
    	t.string :teacher
    end
  end
end
