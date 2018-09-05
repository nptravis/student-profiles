class RemoveSemesterFromSections < ActiveRecord::Migration[5.1]
  def change
  	remove_column :sections, :semester
  end
end
