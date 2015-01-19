class AddHiddenToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :hidden, :boolean, default: false
  end
end
