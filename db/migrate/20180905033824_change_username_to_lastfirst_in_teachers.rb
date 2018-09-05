class ChangeUsernameToLastfirstInTeachers < ActiveRecord::Migration[5.1]
  def change
  	rename_column :teachers, :username, :lastfirst
  end
end
