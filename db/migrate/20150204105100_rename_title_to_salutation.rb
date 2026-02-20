class RenameTitleToSalutation < ActiveRecord::Migration
  def change
    rename_column :users, :title, :salutation
  end
end
