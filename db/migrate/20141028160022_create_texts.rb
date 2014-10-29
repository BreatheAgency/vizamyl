class CreateTexts < ActiveRecord::Migration
  def up
    create_table :texts do |t|
      t.string :title
      t.string :subject_area
    end
    Text.create_translation_table!(
      title: { type: :string, null: false },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :texts
    Text.drop_translation_table!
  end
end
