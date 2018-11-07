class AddSchoolIdToCourse < ActiveRecord::Migration[5.1]
  def change
  	add_column :courses, :school_id, :integer
  end
end
