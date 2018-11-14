class AddPsIdToTeachers < ActiveRecord::Migration[5.1]
  def change
  	add_column :teachers, :ps_id, :integer
  end
end
