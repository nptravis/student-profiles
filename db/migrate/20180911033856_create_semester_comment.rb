class CreateSemesterComment < ActiveRecord::Migration[5.1]
  def change
    create_table :semester_comments do |t|
    	t.integer :student_id 
    	t.integer :section_id
    	t.integer :teacher_id
    	t.string :content
    end
  end
end
