class CreateStandardTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :standard_terms do |t|
    	t.integer :standard_id
    	t.integer :term_id
    end
  end
end
