class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :page_id
      t.string :title
      t.string :subject_area
      t.string :source
    end
    Image.create_translation_table!(
      title: { type: :string },
      subject_area: { type: :string },
      source: { type: :string },
    )
  end

  def down
    drop_table :images
    Image.drop_translation_table!
  end
end
