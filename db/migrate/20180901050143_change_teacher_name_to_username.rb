class ChangeTeacherNameToUsername < ActiveRecord::Migration[5.1]
  def change
  	rename_column :teachers, :name, :username
  end
end
