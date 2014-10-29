class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :title
      t.string :subject_area
      t.string :source
      t.boolean :mandatory, default: true
    end
    Video.create_translation_table!(
      title: { type: :string, null: false },
      subject_area: { type: :string },
      source: { type: :string },
    )
  end

  def down
    drop_table :videos
    Video.drop_translation_table!
  end
end
