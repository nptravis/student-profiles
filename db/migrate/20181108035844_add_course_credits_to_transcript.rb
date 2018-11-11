class AddCourseCreditsToTranscript < ActiveRecord::Migration[5.1]
  def change
  	add_column :transcripts, :eng_credit, :decimal
  	add_column :transcripts, :mat_credit, :decimal
  	add_column :transcripts, :sci_credit, :decimal
  	add_column :transcripts, :soc_credit, :decimal
  	add_column :transcripts, :arts_credit, :decimal
  	add_column :transcripts, :pe_credit, :decimal
  	add_column :transcripts, :rel_credit, :decimal
  	add_column :transcripts, :mod_credit, :decimal
  	add_column :transcripts, :health_credit, :decimal
  	add_column :transcripts, :total_credit, :decimal
  end
end


