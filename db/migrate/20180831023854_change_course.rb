class ChangeCourse < ActiveRecord::Migration[5.1]
  def change
  	remove_column :courses, :section, :integer
  	remove_column :courses, :teacher_email, :string
  end
end
