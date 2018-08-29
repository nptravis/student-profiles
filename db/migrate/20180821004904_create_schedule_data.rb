class CreateScheduleData < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule_data do |t|
    	t.string :expression
    	t.string :course_id
    	t.integer :student_id
    	
    end
  end
end
