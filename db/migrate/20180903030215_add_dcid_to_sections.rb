class AddDcidToSections < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :dcid, :integer
  end
end
