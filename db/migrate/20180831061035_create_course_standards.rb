class CreateCourseStandards < ActiveRecord::Migration[5.1]
  def change
    create_table :course_standards do |t|
    	t.integer :course_id
    	t.integer :standard_id
    end
  end
end
