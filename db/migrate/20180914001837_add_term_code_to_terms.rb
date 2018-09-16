class AddTermCodeToTerms < ActiveRecord::Migration[5.1]
  def change
  	add_column :terms, :term_code, :integer
  end
end
