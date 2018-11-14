class AddAlertToStudents < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :alert, :string
  end
end
