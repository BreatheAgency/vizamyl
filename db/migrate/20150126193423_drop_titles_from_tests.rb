class DropTitlesFromTests < ActiveRecord::Migration
  def change
    remove_column :test_translations, :title
    remove_column :tests, :title
  end
end
