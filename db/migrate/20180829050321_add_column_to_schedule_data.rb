class AddColumnToScheduleData < ActiveRecord::Migration[5.1]
  def change
  	add_column :schedule_data, :expression, :string
  	add_column :schedule_data, :student_id, :integer
  	add_column :schedule_data, :course_id, :integer
  end
end
