class RemoveAbsencesFromSections < ActiveRecord::Migration[5.1]
  def change
  	remove_column :sections, :absences
  end
end
