class CreateTradGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :trad_grades do |t|
    	t.integer "student_id"
	    t.string "grade"
	    t.integer "section_id"
	    t.integer "term_id"
	    t.string "semester"
      t.timestamps
    end
  end
end
