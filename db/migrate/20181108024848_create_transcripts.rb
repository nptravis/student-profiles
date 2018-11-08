class CreateTranscripts < ActiveRecord::Migration[5.1]
  def change
    create_table :transcripts do |t|
      t.integer :student_id
      t.float :cumulative_gpa
      t.float :g9_sem1_gpa
      t.float :g9_sem2_gpa
      t.float :g10_sem1_gpa
      t.float :g10_sem2_gpa
      t.float :g11_sem1_gpa
      t.float :g11_sem2_gpa
      t.float :g12_sem1_gpa
      t.float :g12_sem2_gpa

      t.timestamps
    end
  end
end
