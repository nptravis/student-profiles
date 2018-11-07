class AddSchoolIdToStudent < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :school_id, :integer
  end
end
