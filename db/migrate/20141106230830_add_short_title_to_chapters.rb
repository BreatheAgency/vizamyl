class AddShortTitleToChapters < ActiveRecord::Migration
  def up
    add_column :chapters, :short_title, :string
    Chapter.add_translation_fields! short_title: :string
  end

  def down
    remove_column :chapter_translations, :short_title
    remove_column :chapters, :short_title
  end
end
