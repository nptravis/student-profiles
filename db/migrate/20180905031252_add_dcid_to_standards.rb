class AddDcidToStandards < ActiveRecord::Migration[5.1]
  def change
  	add_column :standards, :dcid, :integer
  end
end
