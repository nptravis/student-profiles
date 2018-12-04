class AddHomeroomToStudents < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :home_room, :string
  end
end
