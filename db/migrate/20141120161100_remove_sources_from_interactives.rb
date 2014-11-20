class RemoveSourcesFromInteractives < ActiveRecord::Migration
  def change
    remove_column :interactives, :sources
  end
end
