class AddDcidToTeachers < ActiveRecord::Migration[5.1]
  def change
  	add_column :teachers, :dcid, :integer
  end
end
