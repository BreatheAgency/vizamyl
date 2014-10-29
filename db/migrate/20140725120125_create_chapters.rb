class CreateChapters < ActiveRecord::Migration
  def up
    create_table :chapters do |t|
      t.integer :position
      t.string :title
      t.timestamps
    end
    Chapter.create_translation_table! title: { type: :string, null: false }
  end
  def down
    drop_table :chapters
    Chapter.drop_translation_table!
  end
end
