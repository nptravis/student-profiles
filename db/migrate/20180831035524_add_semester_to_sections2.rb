class AddSemesterToSections2 < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :semester, :string
  end
end
