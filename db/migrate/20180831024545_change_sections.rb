class ChangeSections < ActiveRecord::Migration[5.1]
  def change
  	rename_column :sections, :student_id, :teacher_id
  	remove_column :sections, :teacher
  end
end
