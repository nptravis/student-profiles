class AddCourseCreditsToTranscript < ActiveRecord::Migration[5.1]
  def change
  	add_column :transcripts, :eng_credit, :float
  	add_column :transcripts, :mat_credit, :float
  	add_column :transcripts, :sci_credit, :float
  	add_column :transcripts, :soc_credit, :float
  	add_column :transcripts, :arts_credit, :float
  	add_column :transcripts, :pe_credit, :float
  	add_column :transcripts, :rel_credit, :float
  	add_column :transcripts, :mod_credit, :float
  	add_column :transcripts, :health_credit, :float
  end
end


