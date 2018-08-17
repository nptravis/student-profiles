class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :lastfirst
      t.string :student_number
      t.string :gradelevel
    end
  end
end
