class AddDcidToCourse < ActiveRecord::Migration[5.1]
  def change
  	add_column :courses, :dcid, :integer
  end
end
