class AddADdressToStudent < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :email, :string
  	add_column :students, :mailing_city, :string
  	add_column :students, :mailing_zip, :string
  	add_column :students, :mailing_street_1, :string
  	add_column :students, :mailing_street_2, :string
  	add_column :students, :guardian_names, :string
  	add_column :students, :mailing_state, :string
  end
end
