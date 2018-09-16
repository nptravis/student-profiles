class ChangeTermInSectionsToTermid < ActiveRecord::Migration[5.1]
  def change
  	rename_column :sections, :termid, :term_id
  end
end
