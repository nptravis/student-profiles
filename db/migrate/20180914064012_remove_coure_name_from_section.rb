class RemoveCoureNameFromSection < ActiveRecord::Migration[5.1]
  def change
  	remove_column :sections, :course_number
  	remove_column :sections, :course_name
  end
end
