class AddSectionIdToGrades < ActiveRecord::Migration[5.1]
  def change
  	add_column :grades, :section_id, :integer
  end
end
