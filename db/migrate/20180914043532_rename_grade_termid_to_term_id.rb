class RenameGradeTermidToTermId < ActiveRecord::Migration[5.1]
  def change
  	rename_column :grades, :termid, :term_id
  end
end
