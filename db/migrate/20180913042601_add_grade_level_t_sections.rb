class AddGradeLevelTSections < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :grade_level, :integer
  end
end
