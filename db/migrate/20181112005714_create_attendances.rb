class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
    	t.integer :absences
    	t.integer :tardies
    	t.integer :student_id
    	t.integer :section_id
      t.timestamps
    end
  end
end
