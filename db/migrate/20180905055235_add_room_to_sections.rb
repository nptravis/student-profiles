class AddRoomToSections < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :room, :string
  end
end
