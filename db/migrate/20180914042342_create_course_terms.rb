class CreateCourseTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :course_terms do |t|
    	t.integer :course_id
    	t.integer :term_id
      t.timestamps
    end
  end
end
