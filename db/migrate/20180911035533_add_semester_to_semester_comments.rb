class AddSemesterToSemesterComments < ActiveRecord::Migration[5.1]
  def change
  	add_column :semester_comments, :semester, :string
  end
end
