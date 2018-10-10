class CreateQuarterComment < ActiveRecord::Migration[5.1]
  def change
    create_table :quarter_comments do |t|
      t.string :content
      t.integer :teacher_id
      t.integer :student_id
      t.integer :section_id
    end
  end
end
