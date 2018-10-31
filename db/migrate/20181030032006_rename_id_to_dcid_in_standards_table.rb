class RenameIdToDcidInStandardsTable < ActiveRecord::Migration[5.1]
  def change
  	rename_column :standards, :parent_standard_id, :parent_standard_dcid
  end
end
