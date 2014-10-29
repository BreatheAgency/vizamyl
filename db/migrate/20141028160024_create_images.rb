class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :title
      t.string :subject_area
    end
    Image.create_translation_table!(
      title: { type: :string, null: false },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :images
    Image.drop_translation_table!
  end
end
