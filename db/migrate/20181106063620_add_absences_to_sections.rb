class AddAbsencesToSections < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :absences, :integer
  end
end
