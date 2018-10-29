class AddParentStandardIdToStandard < ActiveRecord::Migration[5.1]
  def change
  	add_column :standards, :parent_standard_id, :integer
  	add_column :standards, :description, :string
  end
end
