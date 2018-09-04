class AddExpressionToSections < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :expression, :string
  end
end
