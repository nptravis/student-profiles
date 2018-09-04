class ChangeYearToTerm < ActiveRecord::Migration[5.1]
  def change
  	rename_column :sections, :yearid, :termid
  	rename_column :grades, :yearid, :termid
  end
end
