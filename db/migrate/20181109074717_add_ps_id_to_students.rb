class AddPsIdToStudents < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :ps_id, :integer
  end
end
