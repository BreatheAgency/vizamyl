class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :page_id
      t.string :title
      t.text :body
      t.string :subject_area
      t.string :source
      t.text :abbreviations
      t.boolean :mandatory, default: true
    end
    Video.create_translation_table!(
      title: { type: :string },
      body: { type: :text },
      subject_area: { type: :string },
      source: { type: :string },
      abbreviations: { type: :text },
    )
  end

  def down
    drop_table :videos
    Video.drop_translation_table!
  end
end
