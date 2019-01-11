class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :school_id
      t.integer :dcid
      t.integer :ps_id
      t.timestamps
    end
  end
end
