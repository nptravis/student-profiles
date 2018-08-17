class CreateStandards < ActiveRecord::Migration[5.1]
  def change
    create_table :standards do |t|
      t.string :standard_name
      t.string :identifier
    end
  end
end
