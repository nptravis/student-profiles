class CreateTranscripts < ActiveRecord::Migration[5.1]
  def change
    create_table :transcripts do |t|
      t.integer :student_id
      t.decimal :cumulative_gpa
      t.decimal :g9_sem1_gpa
      t.decimal :g9_sem2_gpa
      t.decimal :g9_cumulative_gpa
      t.decimal :g10_sem1_gpa
      t.decimal :g10_sem2_gpa
      t.decimal :g10_cumulative_gpa
      t.decimal :g11_sem1_gpa
      t.decimal :g11_sem2_gpa
      t.decimal :g11_cumulative_gpa
      t.decimal :g12_sem1_gpa
      t.decimal :g12_sem2_gpa
      t.decimal :g12_cumulative_gpa
      t.timestamps
    end
  end
end
