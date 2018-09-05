class AddDcidToStudent < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :dcid, :integer
  end
end
