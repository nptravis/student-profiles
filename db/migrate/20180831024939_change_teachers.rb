class ChangeTeachers < ActiveRecord::Migration[5.1]
  def change
  	add_column :teachers, :email, :string
  	add_column :teachers, :name, :string
  end
end
