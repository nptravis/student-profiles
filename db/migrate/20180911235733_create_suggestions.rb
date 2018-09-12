class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
		t.integer :user_id
		t.string :content
		t.timestamps null: false
    end
  end
end
