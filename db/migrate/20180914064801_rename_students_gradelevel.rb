class RenameStudentsGradelevel < ActiveRecord::Migration[5.1]
  def change
  	rename_column :students, :gradelevel, :grade_level
  end
end
